grammar PythonParser;

program: statement* EOF;

statement: assignment | ifStatement | whileStatement | forStatement | expr | var | flag;

assignment:
    IDENT ASSIGN expr
    | IDENT ASSIGN arr
    | IDENT PLUS_ASS expr
    | IDENT MINUS_ASS expr
    | IDENT MULT_ASS expr
    | IDENT DIV_ASS expr;

ifStatement:
    IF condition ':' block elifStatement* elseStatement?;

elifStatement: ELIF condition ':' block;

elseStatement: ELSE ':' block;

whileStatement: WHILE condition ':' block;
forStatement: FOR IDENT IN iterable ':' block;
iterable: IDENT | functionCall;
functionCall: IDENT '(' argList? ')';
argList: expr (',' expr)*;

block: INDENT statement+ DEDENT;

condition:
    '(' condition ')'
    | NOT condition
    | condition AND condition
    | condition OR condition
    | comparison;

comparison:
    expr LESS_THAN expr
    | expr GREAT_THAN expr
    | expr LESS_EQ expr
    | expr GREAT_EQ expr
    | expr EQUAL expr
    | expr NOTEQU expr
    | expr;

expr:
    '(' expr ')'
    | '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '%' expr
    | expr '+' expr
    | expr '-' expr
    | arr
    | IDENT
    | NUMB
    | STR
    | BOOL;

array: IDENT '=' arr;

arr: '[' elementList? ']';

elementList: arrayElement (',' arrayElement)*;

arrayElement: NUMB | STR | '-' NUMB;

var: IDENT '=' expr;

flag: IDENT '=' BOOL;

IF: 'if';
ELIF: 'elif';
ELSE: 'else';
AND: 'and';
OR: 'or';
NOT: 'not';
INDENT: '<<INDENT>>';
DEDENT: '<<DEDENT>>';

WHILE: 'while';
FOR: 'for';
IN: 'in';

BOOL: 'True' | 'False';

PLUS_ASS: '+=';
MINUS_ASS: '-=';
MULT_ASS: '*=';
DIV_ASS: '/=';
LESS_EQ: '<=';
GREAT_EQ: '>=';
EQUAL: '==';
NOTEQU: '!=';

ASSIGN: '=';
ADD: '+';
SUB: '-';
MULT: '*';
DIV: '/';
MOD: '%';
LESS_THAN: '<';
GREAT_THAN: '>';

IDENT: [a-zA-Z][a-zA-Z0-9_]*;
NUMB: [0-9]+ ('.' [0-9]+)?;
STR: '"' ~["\r\n]* '"' | '\'' ~['\r\n]* '\'';

COMMENT: '#' ~[\r\n]* -> skip;
MULTILINE_COMMENT: '\'\'\'' .*? '\'\'\'' -> skip;

WS: [ \t\n\r]+ -> skip;