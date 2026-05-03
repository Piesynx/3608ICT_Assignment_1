#!/usr/bin/env python3
"""Batch tester for proof search algorithms.

Runs a selected proof search algorithm on a batch of files, times each lemma/conjecture,
records successes, and outputs a graph of time spent per file.
"""

import argparse
import csv
import importlib
import os
import sys
import time
from typing import Dict, List, Optional, Tuple

try:
    import matplotlib.pyplot as plt
    MATPLOTLIB_AVAILABLE = True
except ImportError:
    MATPLOTLIB_AVAILABLE = False

from tptp_parser import FormulaEntry, parse_tptp_file, Formula, Forall, Exists, Not, And, Or, Implies, Iff

# Module-level variables set dynamically by main()
_Sequent = None
_ProofNode = None
_build_proof_and_attempt = None


def count_quantifiers(formula: Formula) -> int:
    """Count the number of quantifiers (forall and exists) in a formula."""
    if isinstance(formula, (Forall, Exists)):
        return 1 + count_quantifiers(formula.formula)
    elif isinstance(formula, (Not,)):
        return count_quantifiers(formula.formula)
    elif isinstance(formula, (And, Or, Implies, Iff)):
        return count_quantifiers(formula.left) + count_quantifiers(formula.right)
    else:
        # Atom, Truth, Falsity
        return 0



def resolve_files(paths: List[str], extensions: Optional[List[str]] = None) -> List[str]:
    resolved: List[str] = []
    extensions = extensions or ['.p', '.fof', '.cnf']
    for path in paths:
        if os.path.isdir(path):
            for root, _, files in os.walk(path):
                for name in sorted(files):
                    if os.path.splitext(name)[1].lower() in extensions:
                        resolved.append(os.path.join(root, name))
        elif os.path.isfile(path):
            resolved.append(os.path.normpath(path))
        else:
            raise FileNotFoundError(f"Path not found: {path}")
    return sorted(set(resolved))


def choose_parser(file_path: str, parser: Optional[str]) -> str:
    if parser:
        return parser
    _, ext = os.path.splitext(file_path)
    if ext.lower() == '.p':
        return 'isabelle'
    return 'tptp'


def parse_file(file_path: str, parser: Optional[str]) -> List[FormulaEntry]:
    effective_parser = choose_parser(file_path, parser)
    if effective_parser == 'tptp':
        return parse_tptp_file(file_path)
    raise ValueError(f"Unknown parser: {effective_parser}")


def collect_conjectures(entries: List[FormulaEntry]) -> List[Tuple[int, FormulaEntry, List[FormulaEntry]]]:
    """Return list of (conjecture_index, conjecture_entry, axioms_before_it)."""
    result: List[Tuple[int, FormulaEntry, List[FormulaEntry]]] = []
    last_conjecture_index = -1
    for idx, entry in enumerate(entries):
        if entry.role.lower() == 'conjecture':
            axioms = [formula for formula in entries[last_conjecture_index + 1:idx] if formula.role.lower() == 'axiom']
            result.append((idx, entry, axioms))
            last_conjecture_index = idx
    return result


def prove_sequent(axioms: List, conjecture_formula, timeout_seconds: float) -> Tuple[bool, float, str]:
    sequent = _Sequent(antecedent=[entry.formula for entry in axioms], succedent=[conjecture_formula])
    deadline = time.time() + timeout_seconds
    start = time.time()
    proof, attempt = _build_proof_and_attempt(sequent, deadline)
    elapsed = time.time() - start
    if proof is not None:
        return True, elapsed, 'proved'
    return False, elapsed, attempt.rule


def run_batch(files: List[str], timeout: float, parser: Optional[str]) -> List[Dict[str, object]]:
    results: List[Dict[str, object]] = []
    for path in files:
        try:
            entries = parse_file(path, parser)
        except Exception as exc:
            results.append({
                'file': path,
                'error': str(exc),
                'total_time': 0.0,
                'total_conjectures': 0,
                'successes': 0,
                'rows': [],
            })
            continue

        conjectures = collect_conjectures(entries)
        total_time = 0.0
        successes = 0
        rows = []
        for (_, conjecture, axioms) in conjectures:
            success, elapsed, status = prove_sequent(axioms, conjecture.formula, timeout)
            total_time += elapsed
            if success:
                successes += 1
            # Count quantifiers in the entire conjecture sequent (axioms + conjecture)
            total_quantifiers = sum(count_quantifiers(ax.formula) for ax in axioms) + count_quantifiers(conjecture.formula)
            rows.append({
                'conjecture': conjecture.name,
                'status': status,
                'time': elapsed,
                'success': success,
                'num_quantifiers': total_quantifiers,
            })

        results.append({
            'file': path,
            'total_time': total_time,
            'total_conjectures': len(conjectures),
            'successes': successes,
            'rows': rows,
            'error': None,
        })
    return results


def plot_results(results: List[Dict[str, object]], output_path: str, timeout: float) -> None:
    labels = [os.path.basename(item['file']) for item in results]
    times = [item['total_time'] for item in results]
    successes = [item['successes'] for item in results]
    total_conjectures = [item['total_conjectures'] for item in results]

    # Build per-conjecture labels and times for subplot 2
    conjecture_labels: List[str] = []
    conjecture_times: List[float] = []
    for item in results:
        file_label = os.path.basename(item['file'])
        for row in item['rows']:
            conjecture_labels.append(f"{file_label}:{row['conjecture']}")
            conjecture_times.append(row['time'])

    # Calculate timeouts per file
    timeouts = []
    for item in results:
        timeout_count = sum(1 for row in item['rows'] if row['status'] == 'timeout' or row['time'] >= timeout)
        timeouts.append(timeout_count)

    failures = [tot - succ - tout for tot, succ, tout in zip(total_conjectures, successes, timeouts)]

    # Aggregate totals across all files
    total_successes = sum(successes)
    total_failures = sum(failures)
    total_timeouts = sum(timeouts)

    # Calculate average time excluding timeouts
    all_times = []
    for item in results:
        for row in item['rows']:
            if row['time'] < timeout:  # exclude timeouts
                all_times.append(row['time'])
    avg_time = sum(all_times) / len(all_times) if all_times else 0.0

    if MATPLOTLIB_AVAILABLE:
        base, ext = os.path.splitext(output_path)
        success_path = f"{base}_success{ext}"
        time_path = f"{base}_time{ext}"

        # Success/failure summary plot
        fig1, ax1 = plt.subplots(figsize=(8, 6))
        ax1.bar(['Successful', 'Failed', 'Timeout'], [total_successes, total_failures, total_timeouts], color=['tab:green', 'tab:red', 'tab:gray'])
        ax1.set_xlabel('Outcome')
        ax1.set_ylabel('Number of Lemmas')
        ax1.set_yticks(range(0, max(total_successes, total_failures, total_timeouts) + 2, 2)) if max(total_successes, total_failures, total_timeouts) < 30 else None
        ax1.set_title('Total Successful, Failed, and Timeout Lemmas')
        fig1.tight_layout()
        fig1.savefig(success_path, bbox_inches='tight')
        plt.close(fig1)
        print(f'Graph saved to: {success_path}')

        # Time-per-conjecture plot
        fig2, ax2 = plt.subplots(figsize=(max(8, len(conjecture_times) * 0.3), 6))
        x = list(range(len(conjecture_times)))
        ax2.bar(x, conjecture_times, color='tab:blue', alpha=0.75, label='Time per conjecture (s)')
        ax2.axhline(y=avg_time, color='tab:orange', linestyle='--', label=f'Average time (excluding timeouts): {avg_time:.3f}s')
        ax2.set_xlabel('Conjecture')
        ax2.set_ylabel('Time (seconds)')
        ax2.set_title('Time per Conjecture')
        ax2.set_xticks(x)
        ax2.set_xticklabels(conjecture_labels, rotation=45, ha='right', fontsize=8)
        ax2.legend()
        fig2.tight_layout()
        fig2.savefig(time_path, bbox_inches='tight')
        plt.close(fig2)
        print(f'Graph saved to: {time_path}')
    else:
        print('matplotlib not installed; graph output skipped. Install matplotlib to generate a PNG graph.')
        print('Results summary:')
        max_label = max(len(label) for label in conjecture_labels) if conjecture_labels else 0
        for label, time_spent in zip(conjecture_labels, conjecture_times):
            bar = '#' * int(min(40, time_spent / max(conjecture_times) * 40)) if max(conjecture_times) > 0 else ''
            print(f'{label:<{max_label}} | {bar:<40} | {time_spent:.3f}s')


def write_csv(results: List[Dict[str, object]], output_path: str, timeout: float) -> None:
    """Write CSV categorizing results by number of quantifiers."""
    from collections import defaultdict
    
    # Aggregate by num_quantifiers
    quant_data = defaultdict(lambda: {
        'total_conjectures': 0,
        'successes': 0,
        'failures': 0,
        'timeouts': 0,
        'times': [],
    })
    
    for item in results:
        if item['error']:
            continue
        for row in item['rows']:
            nq = row['num_quantifiers']
            quant_data[nq]['total_conjectures'] += 1
            if row['success']:
                quant_data[nq]['successes'] += 1
            elif row['status'] == 'timeout' or row['time'] >= timeout:
                quant_data[nq]['timeouts'] += 1
            else:
                quant_data[nq]['failures'] += 1
            quant_data[nq]['times'].append(row['time'])
    
    # Prepare CSV data
    csv_path = output_path.replace('.png', '.csv')
    with open(csv_path, 'w', newline='') as csvfile:
        fieldnames = ['num_quantifiers', 'total_conjectures', 'successes', 'failures', 'timeouts', 'avg_time']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        
        for nq in sorted(quant_data.keys()):
            data = quant_data[nq]
            times = [t for t in data['times'] if t < timeout]  # exclude timeouts
            avg_time = sum(times) / len(times) if times else 0.0
            writer.writerow({
                'num_quantifiers': nq,
                'total_conjectures': data['total_conjectures'],
                'successes': data['successes'],
                'failures': data['failures'],
                'timeouts': data['timeouts'],
                'avg_time': f"{avg_time:.3f}",
            })
    
    print(f'CSV saved to: {csv_path}')


def print_summary(results: List[Dict[str, object]]) -> None:
    print('\nBatch results:')
    for item in results:
        if item['error']:
            print(f"{item['file']}: ERROR - {item['error']}")
            continue
        print(f"{item['file']}: {item['successes']}/{item['total_conjectures']} proven, {item['total_time']:.3f}s")
        for row in item['rows']:
            print(f"  {row['conjecture']}: {row['status']} in {row['time']:.3f}s")


def main() -> int:
    global _Sequent, _ProofNode, _build_proof_and_attempt
    
    parser = argparse.ArgumentParser(description='Run a proof search algorithm on a batch of files and graph results.')
    parser.add_argument('paths', nargs='+', help='Files and/or directories to process')
    parser.add_argument('--timeout', type=float, default=5.0, help='Timeout per conjecture in seconds')
    parser.add_argument('--algorithm', choices=['algorithm2', 'algorithm2_improved', 'algorithm3', 'algorithm4'], default='algorithm2', help='Algorithm to use for proof search (default: algorithm2)')
    parser.add_argument('--parser', choices=['tptp', 'isabelle'], default=None, help='Parser override for all files')
    parser.add_argument('--output', default='batch_results.png', help='Graph output path')
    parser.add_argument('--extensions', nargs='+', default=['.p', '.fof', '.cnf'], help='File extensions to include when a directory is given')

    args = parser.parse_args()
    
    # Dynamically import the selected algorithm
    try:
        algo_module = importlib.import_module(args.algorithm)
        _Sequent = algo_module.Sequent
        _ProofNode = algo_module.ProofNode
        _build_proof_and_attempt = algo_module._build_proof_and_attempt
    except (ImportError, AttributeError) as exc:
        print(f"Error loading algorithm module '{args.algorithm}': {exc}", file=sys.stderr)
        return 1
    
    try:
        files = resolve_files(args.paths, [ext.lower() for ext in args.extensions])
    except FileNotFoundError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    if not files:
        print('No input files found.', file=sys.stderr)
        return 1

    results = run_batch(files, args.timeout, args.parser)
    print_summary(results)
    plot_results(results, args.output, args.timeout)
    write_csv(results, args.output, args.timeout)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
