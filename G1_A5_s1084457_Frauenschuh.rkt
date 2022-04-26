#lang racket
(require racket/trace)

(define (square x)
  (expt x 2))

(define (cube x)
  (expt x 3))


;A1
(define (checkProp x ls)
  (if (null? ls)
      ls
      (cons (x (first ls)) (checkProp x (rest ls)))))

(define (checkPropOneLine x ls)
  (map x ls))

;A2
(define (doAll ls x)
  (map (λ (y) (y x)) ls))

;A3
(define (toCelsius ls)
  (map (λ (x) (* (/ 5 9) (- x 32))) ls))

;A4
(define (countEvenGreater20 ls)
  (length (filter positive? (filter even? (remv* (range 20) ls)))))

(define (sumEvenGreater20 ls)
  (foldr + 0 (filter positive? (filter even? (remv* (range 20) ls)))))

;A5
(foldr + 0 (map cube (filter even? (range 10 101))))

;recursive
(define (getFromIdx idx xs)
  (if (= idx 0)
      xs
      (cdr(getFromIdx (sub1 idx) xs))))

(trace getFromIdx)

;tail-recursive
(define (getFromIdxTail idx xs)
  (if (= idx 0)
      xs
      (getFromIdxTail (sub1 idx) (cdr xs))))

(trace getFromIdxTail)

