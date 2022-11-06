(*
   The execution environment.
*)

type t = TODO_env

let create () = TODO_env

let bind k v env =
  ignore k;
  ignore v;
  ignore env;
  TODO_env

(* TODO *)
let get k env =
  ignore k;
  ignore env;
  None
