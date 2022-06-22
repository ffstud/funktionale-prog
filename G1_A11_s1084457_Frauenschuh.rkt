#lang racket
(require racket/trace)
;### helper functions ###
(define (getlargest ls)
  (cond ((null? ls) #f)
        ((null? (cdr ls))(car ls))
        ((< (car ls) (cadr ls))(getlargest (cdr ls)))
    (else (getlargest (cons (car ls) (cddr ls))))))

(define (largestIndex ls)
  (index-of ls (getlargest ls)))

;### start of assignment ###
(define (makeHydra n [count n] [hydra '()])
  (if (= count 0)
      hydra
      (makeHydra n (sub1 count) (append (list n) hydra))))

(displayln "Create Hydras")

(displayln (makeHydra 3))
(displayln (makeHydra 7))

(displayln "-------------------------------------------")

(define (countCuts hydra procedure [cuts 0])              ;iterative approach, higher order procedure; faster than recursive version
  (display hydra)
  (display " => ")
  (if (empty? hydra) cuts
      (countCuts (procedure hydra) procedure (add1 cuts))))

(define killFirstHead
  (λ (x) (append (makeHydra (sub1 (first x))) (rest x))))  ;kills the first head in the list, better approach for fighting less heads at once

(define killMaxHead
  (λ (x) (append (take x (largestIndex x)) (makeHydra (sub1 (getlargest x))) (drop x (add1(largestIndex x)))))) ;always kills the head with the highest value no matter what position its in

(displayln "Kill Max Head")
(countCuts (makeHydra 3) killMaxHead)

(define (getMaxHeads hydra procedure  [heads 0])
  (if (empty? hydra) heads
      (getMaxHeads (procedure hydra) procedure (max heads (length hydra)))))



(displayln "-------------------------------------------")

(displayln "Kill First Head")
(countCuts (makeHydra 3) killFirstHead)

(display "-------------------------------------------")
(displayln "")
(display "-WORST- Maximum amount of Heads by killing the Head with the hightest value (5-headed-hydra): ")
(getMaxHeads (makeHydra 5) killMaxHead)
(display "-BEST- Maximum amount of Heads by killing the first head (5-headed-hydra): ")
(getMaxHeads (makeHydra 5) killFirstHead)

