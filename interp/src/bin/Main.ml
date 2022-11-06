(*
   Entry point to the executable.
*)

let main () =
  let _env = Interp.Run.repl stdin in
  ()

let () = main ()
