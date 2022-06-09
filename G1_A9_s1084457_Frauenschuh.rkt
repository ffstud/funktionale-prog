#lang racket

#|

--------------------Aufgabe 1--------------------

(λx.λy.λz. - (+ x y) z) 1 2 3
(λy.λz. - (+ 1 y) z) 2 3
(λz. - (+ 1 2) z) 3
( - (+ 1 2) 3)
(- 3 3)
0

--------------------Aufgabe 2--------------------

(λx.λy.(λx. + x x) y) 5 m

alpha conversion:
(λx.λy.(λz. + z z) y) 5 m

thus our variable x is redundant:
(λy.(λz. + z z) y) m

further reduction to normal form:
(λz. + z z) m)
( + m m)

--------------------Aufgabe 3--------------------

(λx.λy. - x(* y 2)) 7 3

--------------------Aufgabe 4--------------------

(λx.λy. - x(* y 2)) 7 3
(λy. - 7(* y 2))3
(- 7 (* 3 2))
(- 7 6)
1

|#
