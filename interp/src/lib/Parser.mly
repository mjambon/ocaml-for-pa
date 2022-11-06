/*
   Grammar for our language. Takes a stream of tokens and turns them
   in a tree (abstract syntax tree or AST) representing the program.

   This is compiled to pure OCaml by menhir, an improved version of ocamlyacc.
   This defines the token types that the lexer must return (Lexer.mll).
*/
%{
  open AST
%}

%token <int> INT
%token <string> STRING
%token <string> IDENT
%token OPEN
%token CLOSE
%token EOF

%type <AST.program> program
%type <AST.expr option> single_expr

/* Two entry points */
%start program
%start single_expr
%%

program:
| xs = exprs; EOF              { xs }

single_expr:
| x = expr                     { Some x }
| EOF                          { None }

exprs:
| xs = list(expr)              { xs }

expr:
| OPEN; xs = exprs; CLOSE      { List xs }
| x = atom                     { Atom x }

atom:
| x = INT       { Int x }
| x = STRING    { String x }
| x = IDENT     { Ident x }
