(*
   This file is compiled into pure OCaml by ocamllex.

   This is the lexer or tokenizer for the interpreter.
   It turns an input stream of bytes into a stream of tokens.
   The token type is defined in Parser.mly. Parser.mly is where
   we defined the grammar of our language.
*)
{
  open Printf
  open Parser
}

let blank = [' ' '\t']+
let newline = '\r'? '\n'
let comment = ';' [^'\n']*

let opchar = ['!' '#' '$' '&' '*' '+' '-' '/' '.' ':' '<' '>' '=' '?' '@' '^'
              '_' '|' '~']

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

let ident = (letter | opchar) (letter | opchar | digit)*

rule token = parse
| '-'? digit+ as x  { INT (int_of_string x) }
| '"'               { STRING (string [] lexbuf) }
| ident as id       { IDENT id }
| '('               { OPEN }
| ')'               { CLOSE }
| blank             { token lexbuf }
| newline           { token lexbuf }
| comment           { token lexbuf }
| _ as c            { failwith (sprintf "Invalid character %C" c) }
| eof               { EOF }

and string acc = parse
| '\\' '\\'            { string ("\\" :: acc) lexbuf }
| '\\' '"'             { string ("\"" :: acc) lexbuf }
| [^'\\' '"']+ as frag { string (frag :: acc) lexbuf }
| '"'                  { String.concat "" (List.rev acc) }
| '\\' _ as s          {
    failwith (sprintf "Invalid escape sequence in string literal: %s" s)
  }
| eof                  { failwith "Unterminated string literal" }
