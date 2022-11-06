(*
   Execute a program.
*)

type error = TODO_error

val eval_expr : Env.t -> IL.expr -> (Env.t, error) Result.t
