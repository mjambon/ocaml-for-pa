# Introduction to OCaml for Program Analysis

This repository contains material for teaching the fundamentals of
OCaml and functional programming that matter for a better
understanding of how programs work.

## Intended audience

Anyone with some basic notions of programming in any language who
wants to understand better how programs are interpreted.

## Prerequisites

* know how to run shell commands, find files on the computer
* required software (teacher's responsibility):
  - git
  - [vscode](https://code.visualstudio.com/) (`code` command) or
    another editor with an editing mode for OCaml
  - opam: package manager for OCaml libraries and
    executables. Make sure you have a opam 2 (`opam --version`). If
    not, install it by following the instructions from the
    [Opam website](https://opam.ocaml.org/doc/Install.html).
  - A recent version of OCaml initialized via `opam switch create 4.14.0`.
    Replace `4.14.0` by the latest version of OCaml if you wish.
  - Opam packages to be installed with `opam install`:
    * `lsp` or `merlin` (depending on your text editor) to show you
      syntax highlighting and type hints.
    * `utop` for interactive use of OCaml. It's a better alternative
      to the `ocaml` command.
    * `dune` for compiling and recompiling OCaml programs made up of
      multiple files.
    * `menhir`, a parser generator used in the final project as a
      better alternative to ocamlyacc.

## Goals

At the end of the class, the successful student will master the
following topics:

* Write code using immutable data structures
* Define and manipulate tree-like data structures
* Use recursive functions instead of `while` loops
* Write an interpreter for a programming language

## Teaching material

* This git repository which includes:
  - the course's outline
  - program stubs with practical instructions
* [OCaml from the Very Beginning](http://ocaml-book.com/),
  book by John Whitington available in paper format and for free
  online.
* The reference documentation for the
  [OCaml standard library](https://v2.ocaml.org/manual/stdlib.html).

## Contents

We follow mostly the structure of the book. Some material will be
skipped, and a large project consisting in writing a program
interpreter will conclude the course.

### Starting Off

Read Chapter 1.

Goals:

* Get the hang of the development environment

### Names and Functions

Read Chapter 2.

Goals:

* Distinguish values from the names given to them
* Get comfortable with function definition and execution

### Case by Case

Read Chapter 3.

Goals:

* Get comfortable with the syntax to inspect values

### Making Lists

Read Chapter 4.

Goals:

* Get comfortable with transforming data whose type is defined
  recursively

### Sorting Things

Read Chapter 5.

Goals:

* More practice
* Implement something non-trivial

### Functions upon Functions upon Functions

Read Chapter 6.

Goals:

* Use parametrized types to implement general-purpose algorithms
* Pass functions as arguments to implement missing functionality in an
  otherwise generic algorithm

### When Things Go Wrong

Read Chapter 7.

Goals:

* Know how to use exceptions
* Start a reflection on the pros and cons of exceptions in various
  situations

### Looking Things Up

Read Chapter 8.

Goals:

* Practice material from previous chapters

### More with Functions

Read Chapter 9.

Goals:

* Get familiar with partial application

### New Kinds of Data

Read Chapter 10.

Goals:

* Learn how to define types that tightly match the structure of your data
* Learn to inspect and transform your data

### Growing Trees

Read Chapter 11.

Goals:

* Learn how to define and use trees

### In and Out

Read Chapter 12.

Goals:

* Be able to read lines from files and print data out

### Putting Things in Boxes

Read Chapter 13.

Goals:

* Learn how to use mutable memory cells (with moderation and for the
  greater good)
* Learn about the existence of references, arrays, and hash tables

### The OCaml Standard Library

Read Chapter 14.

We'll cover briefly the following modules of the standard library:

* `List`, `Array`
* `String`, `Bytes`, `Char`, `Buffer`
* `Hashtbl`
* `Set`, `Map`
* `Printf`

Goals:

* Be aware of what modules and functions are useful for common tasks
  in program analysis

### Final Project: Language Interpreter

We provide a basic setup to build the project as well as a parser.
Your task is to implement an OCaml interpreter for the toy language
specified below. Please also provide the code for a sample program that
demonstrates the features of your implementation. Good luck!

Language specification:

A program is a sequence of expressions. Each expression gets
evaluated immediately according to the evaluation rules. The different
kinds of expressions are:

* computation: a piece of code to evaluate in the current environment
* function (`fun`): a possibly-parametrized piece of code to evaluate later
* binding (`let`): gives a name to a value e.g. `(let x 42)`

The different kinds of computations are:

* literal: an atom denoting a precomputed value such as `42`,
  `"hello"`, or `true`.
* variable substitution: a single identifier to be replaced by its
  value e.g. `x`.
* function call: a parenthesized expression that doesn't start with a
  keyword. The first element must evaluate to a function e.g.
  `(print "hello")` or `((fun (x) (* x x)) 5)`.

A value is the result of evaluating an expression.

Syntax:

An expression is either a single word called an atom, in which case
it's necessary a computation, or a parenthesized expression.
A parenthesized expression is a sequence of items where the
first element determines how the rest will be evaluated.
A semicolon marks the beginning of a comment that extends until the
end of the line.

```
; An atomic expression that evaluates to the number 42.
42

; A call to the predefined '+' function on 2 numbers, evaluating to 2.
(+ 1 1)

; A call to the predefined 'list' construct that creates a list from the given
; items.
(list 1 2 3)

; An invalid expression, since '1' is neither a keyword nor a function.
(1 2 3)

; An anonymous function that multiplies two numbers and adds 1.
; 'fun' is a keyword introducing a function.
(fun (a b) (+ (* a b) 1))

; Declaration of a variable whose value is the number 42. This adds
; the pair ('a', 42) to the environment.
(let a 42)

; An expression that evaluates to 84.
(* a 2)

; A named function definition.
(let f (fun () (+ a 100)))

; A call to the function 'f' we just defined. Evaluates to 102.
(f)

; The value of the function 'f', which is '(fun () (+ a 100))'.
f

; The definition of a function 'is_even' that returns
; 'true' or 'false' depending on whether its argument is even.
(let is_even (fun (x) (= 0 (mod x 2))))

; This evaluates to 'true'.
(is_even 4)

; This evaluates to 'false'.
(is_even 5)

; A string literal, which is a kind of atom.
"Hello"

; A conditional expression. Evaluates to "Goodbye".
(if (= a 3) "Hello" "Goodbye")

; A function that asks the user whether they want to exit the program,
; reads the value, prints a relevant message, and exits if it's what
; they want.
; 'prog' is used to evaluate a sequence of expressions. This returns
; the value of the last expression if there is one or '()' otherwise.
(let quit (fun ()
  (print "Do you really want to quit? [y/N]")
  (let answer (read_line))
  (if (or (= answer "y") (= answer "Y"))
    (prog
      (print "Goodbye!")
      (exit)
    )
    (prog
      (print "Awesome!!!")
    )
  )
))

; The concatenation of three lists, giving the list '(list 1 2 3 4 5)'.
(concat (list 1 2) (list 3) (list 4 5))

; Obtain the tail of a list, which is '(list 2 3)'.
(tail (list 1 2 3))

; Obtain the head of a list, which is '1'.
(head (list 1 2 3))

; Construct a new list by placing a new head in front of an existing
; list. Evaluates to '(list 1 2 3)'.
(cons 1 (list 2 3))

; Check that two different ways of creating a list are equivalent.
(=
  (list 1 2 3)
  (cons 1 (cons 2 (cons 3 (list))))
)

; A recursive function for iterating over a list.
(let iter (fun (f xs)
  (if (<> xs (list))
    (prog
      (f (head xs))
      (iter f (tail xs))
    )
  )
))

; Print the elements of a list, one per line.
(iter print (list 1 2 3))

; Functions use the environment available at the time of their
; definition. The code below prints "hello", not "hi".
(let msg "hello")
(let greet () (print msg))
(let msg "hi")
(greet)

; Optional: partial function application.
; Evaluates to 16.
(let f (fun (a b c) (+ a (* b c))))
((f 1 3) 5)
```

Tasks:

* Build and run the initial code. Instructions are in the
  makefile.
* Inspect the source code to see what's there.
* Define the intermediate language (IL, file `IL.ml`).
* Start implementing the evaluator (`Eval.ml`). You can start by
  leaving all but the simplest operations unimplemented for now.
* Print the result of evaluating an expression entered by the user.
* Handle syntax errors gracefully as needed. Take care of possible
  bugs in the code provided by the teacher.
* Add functionality to the evaluator. For this, start a collection of
  test cases, i.e. sample programs written in the target language,
  and run the `interp` program.

Ideas for extra credits:

* Write a useful program in the new language.
* Add support for partial application.
* Write and load a library of functions to manipulate lists.
* Add support for references.
* Add support for pattern matching. Note that a representation for
  sum types is already available in the base language since there's
  no typechecking and lists, tuples, and variants all use the basic
  atom and list building blocks.
