#lang racket
(require racket/trace)

(define (square x)
  (expt x 2))
(define (cube x)
  (expt x 3))

;A1
(define (min-fx-gx f g x)
  (min (f x) (g x)))

(define (combine-fx-gx p f g x)
  (p (f x) (g x)))

;A2
(define (f g)
 (g 5))

#|
(f +) -> 5, weil (+ 5) = 5
(f square) -> 25, weil (square 5) = 25
(f (lambda (x) (* x (+ x 2)))) -> 35, weil (* 5 (+ 5 2)) = 35
(f f) -> error, weil (f f) -> (f 5) -> (5 5) und 5 ist keine Prozedur
|#

;A3
(define (sumrec term a b)
  (if (> a b) 0
     (+ (term a)
        (sumrec term (+ a 1) b))))

(define (sum term a b)
    (define (sum-iter a b ans)
      (if (> a b) ans
          (sum-iter (add1 a) b (+ ans (term a)))))
(trace sum-iter)
  (sum-iter a b 0))


;A4
(define ((twice f) x)
  (define (lambda x n)
    (x (x n)))
  (lambda f x))

(define ((comp f g) x)
  (define (lambda term1 term2 n)
    (term1 (term2 n)))
    (lambda f g x))

;A5
(define (mycons x y)
 (define (dispatch m)
 (cond [(= m 0) x]
 [(= m 1) y]
 [else (error "argument not 0 or 1 -- in mycons" m)]))
 dispatch)

(define (mycar z) (z 0))
(define (mycdr z) (z 1))


(define (add-complex c1 c2)
  (mycons (+ (mycar c1) (mycar c2))(+ (mycdr c1) (mycdr c2))))

(define (print-complex x)
  (display (mycar x))
  (cond ((>= (mycdr x) 0) (display "+")))
  (display (mycdr x))
  (display "i"))

;(define num1 (mycons -1 3))      variables for testing purposes
;(define num2 (mycons 1 -100))