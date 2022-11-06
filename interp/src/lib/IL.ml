(*
   Intermediate language.

   A language representation that's more specific than the AST and simplifies
   the code that will execute the program.
*)

type var = TODO_var

type value = TODO_value

(* This should include dedicated node kinds for built-in constructs
   such as let-bindings or function definitions. *)
type expr = TODO

type program = expr list

(*
   Convert an AST to a more specific representation.
   You may choose to fail here if some invalid constructs are encountered,
   or it can be delayed until the execution of the program.
*)
let translate_expr (x : AST.expr) : expr =
  ignore x;
  TODO
