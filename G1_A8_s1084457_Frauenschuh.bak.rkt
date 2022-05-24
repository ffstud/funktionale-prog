#lang racket
(require racket/trace)


(define (s-display s)
  (if (s-empty? s)
      ""
      (~a (s-first s) "," (s-display (s-rest s)))))

(define (s-range low high)
  (if (>= low high)
      empty-s
      (s-cons
       low
       (s-range (+ low 1) high))))

(define int2 (s-range 0 10))


(define (toCelsius ls)
  (map (λ (x) (* (/ 5 9) (- x 32))) ls))


(define-syntax-rule (s-cons a b)
 (cons a (delay b)))

(define (s-first s)
 (car s))

(define (s-empty? s)
  (empty? s))

(define (s-rest s)
 (force (cdr s)))

(define (s-map proc s)
 (if (s-empty? s)
 empty-s
 (s-cons (proc (s-first s)) (s-map proc (s-rest s)))))

(define empty-s 'S-EMPTY-STREAM)

(define (s-display-limit s limit)
  (if (or (= limit 0) (s-empty? s))
      "...?"
      (~a (s-first s) "," (s-display-limit (s-rest s) (- limit 1)))))
;for testing purposes:
(define (isf n)
 (s-cons n (isf (+ n 1))))

(define integers (isf 1))

(define s (s-cons 1 (s-cons 2 (s-cons 3 (s-cons 4 5)))))

(define xs (list 1 2 3 4 5))

;A1-------------------------------------------------------------
(displayln "----------A1----------")
(display "a) ")

(define (s-length s1 (length 0))
  (if (pair? s1)
      (s-length (s-rest s1) (add1 length))
      length))
     
(s-length (s-range 1 101))

(display "b) ")
(define (toCelsius-stream s1)
  (s-map (λ (temp) (* (/ 5 9) temp)) (s-map (λ (temp) (- temp 32)) s1)))

(s-display-limit (toCelsius-stream integers) 4)

;A2-------------------------------------------------------------
(displayln "----------A2----------")
(display "a) ")

(define (list2s xs)
  (if (null? xs)
      xs
  (s-cons (first xs) (list2s (rest xs)))))

(s-display (list2s xs))

(display "b) ")

(define (s2list s1)
  (if (pair? s1)
      (cons (s-first s1) (s2list (s-rest s1)))
      (flatten s1)))

(s2list s)
   
;A3-------------------------------------------------------------
(displayln "----------A3----------")

(define (powersOf2 n)
 (s-cons n (powersOf2 (* 2 n))))

(define pO2 (powersOf2 64))

(s-display-limit (powersOf2 64) 10)

;A4--------------------------------------------------------------
(displayln "----------A4----------")

(define (integers-starting-from n)
 (s-cons n (integers-starting-from (+ n 1))))

(define int (integers-starting-from 1))

(define (s-add s1 s2)
  (s-cons (+ (s-first s1) (s-first s2)) (s-add (s-rest s1)(s-rest s2))))

(s-display-limit (s-add int int) 10)

;A5--------------------------------------------------------------
(displayln "----------A5----------")

(define (mySum s (before 0))
  (if (s-empty? s)
      empty-s
  (s-cons (+ (s-first s) before) (mySum (s-rest s) (+ (s-first s) before)))))

(s-display-limit (mySum int) 10)

