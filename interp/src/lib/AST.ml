(*
   Abstract syntax tree for our language.
*)

type atom =
  | Int of int
  | String of string
  | Ident of string

type expr =
  | Atom of atom
  | List of expr list

type program = expr list
