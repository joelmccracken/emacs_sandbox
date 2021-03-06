
(load-file "./spec/spec-helpers.el")
(readme-start)
(readme "

= Elisp Sandbox: run Emacs Lisp in a jail =

Erbot runs the #emacs robot. He has a jail inside him for running
arbitary elisp safely.

The code is here: git://git.sv.gnu.org/erbot.git

Also on GitHub [[https://github.com/sigma/erbot|here]].

The goal of this project is to take erbot's code and adapt it for general use.

It is very much a work in progress. Feel free to help out!

== How to use it ==

First load elisp-sandbox.el. It provides a number of functions that support working
with Emacs Lisp code in a safe way.

The simplest function is {{{elisp-sandbox-eval}}}. Using it will evaluate the code
in a way that prevents the code from calling any disallowed functions.

== How it Works ==

The elisp sandbox works by prefixing any symbols it receives as input
before that input is evaluated. That way, the user can only access symbols
that begin with that prefix. For example,

")

(sandbox-defexample
 "a simple example that demonstrates expansion"
 (elisp-sandbox '(setq x 100))
 (elisp-sandbox-unsafe-env-setq elisp-sandbox-unsafe-env-x 100))

(readme "

and:

")

(sandbox-defexample
 "a second example that demonstrates expansion with a defun (a more complex form)"
 (elisp-sandbox '(defun nic-test-2 () 100))
 (elisp-sandbox-unsafe-env-defun elisp-sandbox-unsafe-env-nic-test-2 nil 100))


(readme "
== Programmer API ==

To evaluate unsafe code:

{{{ (elisp-sandbox-eval <unsafe code here>) }}}

Example:


")

(sandbox-defexample
 "a simple evaluation example"
 (elisp-sandbox-eval '(+ 1 2))
 3)


(readme "

Any output is stored as a list of strings in the symbol:

{{{elisp-sandbox-evaluation-output}}}

")


(sandbox-defexample
 "example showing output"
 (elisp-sandbox-eval '(message "Hello World!"))
 ("Hello World!")
  ("Hello World!"))




(readme "

== Sandbox Internal API ==

Sandbox provides a number of functions and macros that are accessible to untrusted code.

{{{defun}}} -- Defines a function specific to the sandbox environment.

{{{while}}} -- Basic looping. Has a maxium loop depth foncigurable with {{{ sandbox-while-max }}} .


")



(sandbox-defexample
 "shows while looping"
 (elisp-sandbox-eval
  '(progn
     (setq counter 0
           total 0)
     (while (< counter 10)
       (setq total (+ total counter))
       (setq counter  (+ 1 counter)))
     total))
 45)


(readme "

The maximum execution while depth can be configured:

")



(sandbox-defexample
 "shows looping that would be deeper than allowed"
 (let ((sandbox-while-max 2))
   (if (elisp-sandbox-eval
        '(ignore-errors
           (setq counter 0
                 total 0)
           (while (< counter 10)
             (setq total (+ total counter))
             (setq counter  (+ 1 counter)))
           t))
       "A non-nil resuld would mean that the while finished and t was returned"
     "A nil result means an error happend, as expected!"))
 "A nil result means an error happend, as expected!")



(readme "




{{{message}}} -- method for saving output.

The following are available as aliases of the standard functions:

{{{setq}}}, {{{<}}}, {{{+}}}, {{{progn}}}, {{{let}}}, {{{ignore-errors}}}, {{{if}}}

== Sandbox Errors ==

When code behaves badly, errors can be thrown. we gotta figure out how to handle these well.

== Future ==

* it would be nice to allow changing of prefixes, declaration with diff prefixes, and cleaning up
  of prefixes. That way a single process can handle different sandboxes.

* still need to figure out which additional functions need to come from erbot

* features to port
  funcall, apply, pi, e, emacs-version

== Development ==

Use the script {{{ bin/clone_erbot.sh }}} to get a local copy of the erbot source for yourself.

Tests are written with ert.

== Tests ==

Run the file

{{{
./test.sh
}}}

Tests can also be run interactively... TODO document this
")





(readme "
== About This Readme ==

Readme content is automatically generated from the file README-spec.el,
in the same directory. Its examples are used as feature tests. Do not
edit README.creole directly; instead, edit README-spec.el and regenerate
README.creole.

Each feature is covered more thoroughly in the specs/ directory.
")

;; illustrating each feature from the readme
;; examples match headers


;; == How to use it ==

