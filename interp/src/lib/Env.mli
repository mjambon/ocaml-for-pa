(*
   The execution environment.

   It holds the set of bound variables and anything else that we want
   to keep track during the execution of a program.
*)

type t

val create : unit -> t
val bind : IL.var -> IL.value -> t -> t
val get : IL.var -> t -> IL.value option
