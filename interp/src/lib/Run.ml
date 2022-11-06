(*
   Read a program and execute it.
*)

let input_expr in_chan =
  let lexbuf = Lexing.from_channel in_chan in
  match Parser.single_expr Lexer.token lexbuf with
  | None -> None
  | Some e -> Some (IL.translate_expr e)

(* Read-eval-print loop: read expressions one by one *)
let repl ic =
  let rec loop env =
    let opt_expr = input_expr ic in
    match opt_expr with
    | Some e ->
        let env =
          match Eval.eval_expr env e with
          | Ok env -> env
          | Error _err -> env
        in
        flush stdout;
        flush stderr;
        loop env
    | None ->
        env
  in
  loop (Env.create ())
