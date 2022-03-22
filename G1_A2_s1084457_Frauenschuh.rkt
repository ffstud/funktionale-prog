;s12109584 Frauenschuh Florian

#lang racket
(require racket/trace)

;globale Prozeduren

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (square x)
  (expt x 2))

(define (cube x)
  (expt x 3))

(define (average x y)
  (/ (+ x y) 2))

;A1

(define (cuberoot x)
  (define (cbrt-iter guess x)
  (define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))
  (cbrt-iter 1.0 x))

;A2

(define (newton2 x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (trace sqrt-iter)
  (sqrt-iter 1.0 x))

#|
Iterativ, weil am Ende immer ein Wert zurückgegeben wird und keine Prozedur.
Wenn man Trace verwendet kann man dann sehen, dass keine "Stacks" entstehen, sondern immer Werte weiter gegeben werden

> (newton2 100)
>(sqrt-iter 1.0 100)
>(sqrt-iter 50.5 100)
>(sqrt-iter 26.24009900990099 100)
>(sqrt-iter 15.025530119986813 100)
>(sqrt-iter 10.840434673026925 100)
>(sqrt-iter 10.032578510960604 100)
>(sqrt-iter 10.000052895642693 100)
>(sqrt-iter 10.000000000139897 100)
<10.000000000139897
|#

;A3

(define (powerCloseTo b n)
  (define (bigger? x)
    (> (expt b x) n))
  (define (find x)
    (if (bigger? x)
      x
      (find (+ x 1))))
  (find 1.0))

;A4
(define (myif predicate then-clause else-clause)
 (cond (predicate then-clause)
 (else else-clause)))

(define (newton3 x)
  (define (good-enough? guess)
    (<= (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (myif (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (trace sqrt-iter)
  (sqrt-iter 1.0))
#|
-----Endlosschleife-----
geht jedes mal wieder in den "else Zweig", weil das System die if Klausel als abgeschlossen sieht, wenn der guess gut genug ist.
d.h. danach wird dann wieder sqrt-iter ausgeführt, weil das die nächste angegebene Prozedur ist
|#

;A5
(define (fib n)
 (cond ((= n 0) 0)
 ((= n 1) 1)
 (else (+ (fib (- n 1))
 (fib (- n 2))))))
(trace fib)
;-> cpu time: 8187 real time: 8712 gc time: 15 für (fib 10)

(define (fibiter n)
  (define (fib-iter a b n)
  (if (zero? n) a
      (fib-iter (+ a b) a (- n 1))))
    (trace fib-iter)
  (fib-iter 0 1 n))
;-> cpu time: 46 real time: 54 gc time: 0 für (fibiter 10)

;-----fibiter ist viel schneller als die rekursive Variante-----
