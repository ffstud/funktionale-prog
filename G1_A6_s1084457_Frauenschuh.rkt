;12109584, Frauenschuh


#lang racket
(require racket/trace)

;A1
(define binary (list (list 1 (list 3 4)) (list 5 6)))
(define treeDepth3 (list 1 2 (list 3 (list 4 5)) (list 6 7 8 9)))
(define treeDepth4 (list 3 (list 1 4 (list 2 (list 8 9)) (list 10 7)) (list 11 12)))
(define tree1 (cons (list 1 2) (list 3 4 5)))
(define tree2 (list 1 (list 2 3)))
(define x (list (list 1 2) (list 3 4)))

;A2

(define (accumulate-tree tree term op init)
  (cond ((null? tree) init)
        ((not (pair? tree)) (term tree))
        (else (op (accumulate-tree (car tree) term op init)
                  (accumulate-tree (cdr tree) term op init)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;Accumulate funktioniert nicht mit nested lists

(define t (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (count tree)
  (accumulate-tree tree (lambda (x) 1) + 0))

(define (sum tree)
  (accumulate-tree tree append + 0))


;A3
(define (leaflist t)
  (flatten t))
  
(define xs (list (list 1 2) (list 3 4)))

;A5
(define (nestingLevel xs (level 1))
  (if (list? xs)
      (+ level (apply max (map nestingLevel xs))) 0)) ;Apply == map for nested lists
