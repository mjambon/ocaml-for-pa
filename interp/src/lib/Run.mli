(*
   Parse and execute a program.
*)

(* Read-eval-print loop: read and execute expressions one by one
   until reaching the end of input. *)
val repl : in_channel -> Env.t
