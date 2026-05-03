import os
import re
from dataclasses import dataclass
from typing import List, Dict, Optional, Tuple, Union

class TptpParserError(Exception):
    def __init__(self, message: str, source: Optional[str] = None, line: Optional[int] = None, column: Optional[int] = None, line_text: Optional[str] = None):
        self.source = source
        self.line = line
        self.column = column
        self.line_text = line_text
        location = ''
        if source is not None and line is not None and column is not None:
            location = f' ({source}:{line}:{column})'
        elif source is not None:
            location = f' ({source})'
        details = f"{message}{location}"
        if line_text is not None:
            details += f"\n  {line_text}"
        super().__init__(details)

@dataclass(frozen=True)
class Term:
    name: str
    args: Tuple['Term', ...] = ()

    def is_variable(self) -> bool:
        return self.name[:1].isupper() or self.name.startswith("_")

    def __str__(self) -> str:
        if self.args:
            return f"{self.name}({', '.join(map(str, self.args))})"
        return self.name

@dataclass(frozen=True)
class Formula:
    pass

@dataclass(frozen=True)
class FormulaEntry:
    name: str
    role: str
    formula: Formula

@dataclass(frozen=True)
class Atom(Formula):
    predicate: str
    terms: Tuple[Term, ...] = ()

    def __str__(self) -> str:
        if self.terms:
            return f"{self.predicate}({', '.join(map(str, self.terms))})"
        return self.predicate

@dataclass(frozen=True)
class Not(Formula):
    formula: Formula

    def __str__(self) -> str:
        return f"~{self.formula}"

@dataclass(frozen=True)
class And(Formula):
    left: Formula
    right: Formula

    def __str__(self) -> str:
        return f"({self.left} & {self.right})"

@dataclass(frozen=True)
class Or(Formula):
    left: Formula
    right: Formula

    def __str__(self) -> str:
        return f"({self.left} | {self.right})"

@dataclass(frozen=True)
class Implies(Formula):
    left: Formula
    right: Formula

    def __str__(self) -> str:
        return f"({self.left} => {self.right})"

@dataclass(frozen=True)
class Iff(Formula):
    left: Formula
    right: Formula

    def __str__(self) -> str:
        return f"({self.left} <=> {self.right})"

@dataclass(frozen=True)
class Forall(Formula):
    variable: str
    formula: Formula

    def __str__(self) -> str:
        return f"![{self.variable}] : {self.formula}"

@dataclass(frozen=True)
class Exists(Formula):
    variable: str
    formula: Formula

    def __str__(self) -> str:
        return f"?[{self.variable}] : {self.formula}"

@dataclass(frozen=True)
class Truth(Formula):
    def __str__(self) -> str:
        return "$true"

@dataclass(frozen=True)
class Falsity(Formula):
    def __str__(self) -> str:
        return "$false"


class Token:
    def __init__(self, kind: str, text: str, pos: int, line: int, column: int, line_text: str):
        self.kind = kind
        self.text = text
        self.pos = pos
        self.line = line
        self.column = column
        self.line_text = line_text

    def __repr__(self) -> str:
        return f"Token({self.kind}, {self.text!r}, {self.pos}, line={self.line}, col={self.column})"


def _strip_comments(text: str) -> str:
    result = []
    i = 0
    length = len(text)
    in_string = False
    string_char = None
    while i < length:
        c = text[i]
        if in_string:
            result.append(c)
            if c == string_char:
                in_string = False
            i += 1
            continue
        if c in "'\"":
            in_string = True
            string_char = c
            result.append(c)
            i += 1
            continue
        if c == '%':
            while i < length and text[i] != '\n':
                i += 1
            continue
        if c == '/' and i + 1 < length and text[i + 1] == '*':
            i += 2
            while i + 1 < length and not (text[i] == '*' and text[i + 1] == '/'):
                i += 1
            i += 2
            continue
        result.append(c)
        i += 1
    return ''.join(result)


_TOKEN_SPEC = [
    ('STRING', r"'[^']*'|\"[^\"]*\""),
    ('NAME', r"#?[A-Za-z][A-Za-z0-9_]*"),
    ('NUMBER', r"[0-9]+"),
    ('OP', r"<=>|=>|~|!|\?|\&|\||\(|\)|\[|\]|:|,|\.|=|!=|<=|>=|<|>"),
    ('SKIP', r"[ \t\r\n]+"),
    ('MISMATCH', r".")
]
_TOKEN_RE = re.compile('|'.join(f'(?P<{name}>{pattern})' for name, pattern in _TOKEN_SPEC))


def _tokenize(text: str, source: str = '<string>') -> List[Token]:
    text = _strip_comments(text)
    tokens: List[Token] = []
    line = 1
    line_start = 0
    for mo in _TOKEN_RE.finditer(text):
        kind = mo.lastgroup
        value = mo.group()
        pos = mo.start()
        if kind == 'SKIP':
            if '\n' in value:
                line += value.count('\n')
                line_start = pos + value.rfind('\n') + 1
            continue
        column = pos - line_start + 1
        end_of_line = text.find('\n', line_start)
        if end_of_line == -1:
            line_text = text[line_start:]
        else:
            line_text = text[line_start:end_of_line]
        if kind == 'MISMATCH':
            raise TptpParserError(
                f"Unexpected character {value!r}",
                source=source,
                line=line,
                column=column,
                line_text=line_text,
            )
        tokens.append(Token(kind, value, pos, line, column, line_text))
    column = len(text) - line_start + 1
    line_text = text[line_start:]
    tokens.append(Token('EOF', '', len(text), line, column, line_text))
    return tokens


class _TokenStream:
    def __init__(self, tokens: List[Token], source: Optional[str] = None) -> None:
        self.tokens = tokens
        self.index = 0
        self.source = source

    def peek(self) -> Token:
        return self.tokens[self.index]

    def next(self) -> Token:
        token = self.tokens[self.index]
        self.index += 1
        return token

    def expect(self, expected: Union[str, Tuple[str, ...]]) -> Token:
        token = self.peek()
        if isinstance(expected, tuple):
            if token.text in expected:
                return self.next()
        elif token.text == expected:
            return self.next()
        raise TptpParserError(
            f"Expected {expected} at position {token.pos}, got {token.text}",
            source=self.source,
            line=token.line,
            column=token.column,
            line_text=token.line_text,
        )

    def match(self, expected: Union[str, Tuple[str, ...]]) -> Optional[Token]:
        token = self.peek()
        if isinstance(expected, tuple):
            if token.text in expected:
                return self.next()
        elif token.text == expected:
            return self.next()
        return None


def _parse_top_level(tokens: List[Token], source: str, base_dir: str, included: Optional[Dict[str, List[FormulaEntry]]] = None) -> List[FormulaEntry]:
    if included is None:
        included = {}
    stream = _TokenStream(tokens, source=source)
    formulas: List[FormulaEntry] = []
    while stream.peek().kind != 'EOF':
        if stream.peek().text in ('include', '#include'):
            stream.next()
            stream.expect('(')
            include_token = stream.next()
            if include_token.kind != 'STRING':
                raise TptpParserError(
                    f"Expected include filename string",
                    source=source,
                    line=include_token.line,
                    column=include_token.column,
                    line_text=include_token.line_text,
                )
            path_text = include_token.text[1:-1]
            stream.match(',')
            stream.expect(')')
            stream.expect('.')
            resolved = os.path.join(base_dir, path_text)
            resolved = os.path.normpath(resolved)
            if resolved in included:
                continue
            included[resolved] = []
            formulas.extend(parse_tptp_file(resolved, included))
            continue
        if stream.peek().text == 'fof':
            stream.next()
            stream.expect('(')
            name_token = stream.next()
            if name_token.kind not in ('NAME', 'STRING'):
                raise TptpParserError(
                    f"Expected formula name",
                    source=source,
                    line=name_token.line,
                    column=name_token.column,
                    line_text=name_token.line_text,
                )
            stream.expect(',')
            role_token = stream.next()
            if role_token.kind not in ('NAME', 'STRING'):
                raise TptpParserError(
                    f"Expected formula role",
                    source=source,
                    line=role_token.line,
                    column=role_token.column,
                    line_text=role_token.line_text,
                )
            stream.expect(',')
            formula = _parse_formula(stream)
            stream.expect(')')
            stream.expect('.')
            formulas.append(FormulaEntry(name=name_token.text, role=role_token.text, formula=formula))
            continue
        # Skip any stray tokens until next known directive or formula declaration.
        current = stream.next()
        if current.text == '.':
            continue
        raise TptpParserError(
            f"Unexpected top-level token {current.text!r}",
            source=source,
            line=current.line,
            column=current.column,
            line_text=current.line_text,
        )
    return formulas


def _parse_formula(stream: _TokenStream) -> Formula:
    return _parse_iff(stream)


def _parse_iff(stream: _TokenStream) -> Formula:
    left = _parse_implies(stream)
    while stream.match('<=>'):
        right = _parse_implies(stream)
        left = Or(left=And(left=left, right=right), right=And(left=Not(formula=left), right=Not(formula=right)))
    return left


def _parse_implies(stream: _TokenStream) -> Formula:
    left = _parse_or(stream)
    while stream.match('=>'):
        right = _parse_or(stream)
        left = Implies(left=left, right=right)
    return left


def _parse_or(stream: _TokenStream) -> Formula:
    left = _parse_and(stream)
    while stream.match('|'):
        right = _parse_and(stream)
        left = Or(left=left, right=right)
    return left


def _parse_and(stream: _TokenStream) -> Formula:
    left = _parse_not(stream)
    while stream.match('&'):
        right = _parse_not(stream)
        left = And(left=left, right=right)
    return left


def _parse_not(stream: _TokenStream) -> Formula:
    if stream.match('~'):
        return Not(formula=_parse_not(stream))
    token = stream.peek()
    if token.text in ('!', '?'):
        return _parse_quantifier(stream)
    if token.text == '(':
        stream.next()
        inner = _parse_formula(stream)
        stream.expect(')')
        return inner
    return _parse_atom(stream)


def _parse_quantifier(stream: _TokenStream) -> Formula:
    quant = stream.next().text
    stream.expect('[')
    vars_: List[str] = []
    while True:
        name_token = stream.next()
        if name_token.kind != 'NAME':
            raise TptpParserError(
                f"Expected variable name for quantifier",
                source=stream.source,
                line=name_token.line,
                column=name_token.column,
                line_text=name_token.line_text,
            )
        vars_.append(name_token.text)
        if stream.match(']'):
            break
        stream.expect(',')
    stream.expect(':')
    formula = _parse_formula(stream)
    if len(vars_) != 1:
        for var in reversed(vars_):
            formula = Forall(variable=var, formula=formula) if quant == '!' else Exists(variable=var, formula=formula)
        return formula
    return Forall(variable=vars_[0], formula=formula) if quant == '!' else Exists(variable=vars_[0], formula=formula)


def _parse_atom(stream: _TokenStream) -> Formula:
    token = stream.next()
    if token.kind != 'NAME':
        raise TptpParserError(
            f"Expected predicate or term",
            source=stream.source,
            line=token.line,
            column=token.column,
            line_text=token.line_text,
        )
    name = token.text
    if stream.match('('):
        terms = _parse_term_list(stream)
        stream.expect(')')
        if name == '$true':
            return Truth()
        if name == '$false':
            return Falsity()
        return Atom(predicate=name, terms=tuple(terms))
    if name == '$true':
        return Truth()
    if name == '$false':
        return Falsity()
    return Atom(predicate=name, terms=())


def _parse_term_list(stream: _TokenStream) -> List[Term]:
    terms: List[Term] = []
    while True:
        terms.append(_parse_term(stream))
        if stream.match(')'):
            stream.index -= 1
            break
        stream.expect(',')
    return terms


def _parse_term(stream: _TokenStream) -> Term:
    token = stream.next()
    if token.kind == 'NAME':
        name = token.text
        if stream.match('('):
            args = _parse_term_list(stream)
            stream.expect(')')
            return Term(name=name, args=tuple(args))
        return Term(name=name)
    if token.kind == 'NUMBER':
        return Term(name=token.text)
    raise TptpParserError(
        f"Unexpected token {token.text!r} while parsing term",
        source=stream.source,
        line=token.line,
        column=token.column,
        line_text=token.line_text,
    )


def parse_tptp_file(path: str, included: Optional[Dict[str, List[FormulaEntry]]] = None) -> List[FormulaEntry]:
    path = os.path.normpath(path)
    if not os.path.isfile(path):
        raise TptpParserError(f"File not found: {path}")
    with open(path, 'r', encoding='utf-8') as handle:
        text = handle.read()
    tokens = _tokenize(text, path)
    base_dir = os.path.dirname(path)
    formulas = _parse_top_level(tokens, path, base_dir, included)
    if included is not None:
        included[path] = formulas
    return formulas


def parse_tptp_text(text: str, source: str = '<string>') -> List[FormulaEntry]:
    tokens = _tokenize(text, source)
    return _parse_top_level(tokens, source, os.getcwd(), {})
