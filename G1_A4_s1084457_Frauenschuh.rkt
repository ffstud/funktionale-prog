#lang racket
(require racket/trace)

(define list1 (list 1 2 3 4))
(define empty (list null))
(define list2 (list 1 4 2 3 6 7 8))
(define list3 (list  1 3 4))
(define list4 (list 4 5 6))

;A1

(define (mylast xs)
  (if (null? (cdr xs))(car xs)
      (mylast (cdr xs))))
(trace mylast)


;A2
(define (tailLength items (length 0))
  (if (null? items) length
      (tailLength (cdr items) (add1 length))))
(trace tailLength)

;A3
(define (combine op xs ys)
  (if (null? xs) xs
      (cons (op (car xs) (car ys)) (combine op (cdr xs) (cdr ys)))))

;A4
(define (isSame xs ys)
  (if (not(= (length xs) (length ys))) #f
      (if (null? xs) #t
          (if (= (car xs) (car ys)) (isSame (cdr xs) (cdr ys))
              #f))))
(trace isSame)

