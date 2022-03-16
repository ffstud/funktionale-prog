;s12109584 Frauenschuh Florian 

#lang racket

;A1

(define (sign x)
  (cond ((> x 0) 1)
        ((< x 0) -1)
        ((= x 0) 0)))

;A2

(define (sumSquareSmaller x y z)
  (- (+ (* x x) (* y y) (* z z)) (*(max x y z) (max x y z)))) ;builds the sum of all three squares and subtracts the largest squared number

;A3

(define (areaRect length width)
  (* length width))

(define (circumferenceCircle radius)
  (* 2 pi radius))

;A4

(define (mynot x)
  (nor x x))

; examples short-circuit-evaluation

(or #t (= (/ 0 0) 1))  
(and #f (= (/ 0 0) 1)) ;division by zero ignored in both cases

;A5

(define (print x)
 (display x)
 (newline))

(define (countUp x)
 (cond ((= x 0) (print x))
       (else (countUp (- x 1))
                      (print x))))
             
