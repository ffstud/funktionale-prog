;Frauenschuh Florian, 12109584

#lang racket
(require math/statistics)
(require racket/trace)

(define ls1 (list 1 2 3 4 5 6))
(define lsFahrenheit (list 32 95 50))
(define lsRain (list 1 2 -100 -999 1000))

;A1--------------------------------------------------------
(define (toCelsius ls)
  (for/list ((x ls))
    (* (/ 5 9) (- x 32))))

;A2--------------------------------------------------------
(define (rain xs)
  (mean (for/list ((i xs)
                   #:break (= i -999)
                   #:when (> i 0))
          i)))
;A3--------------------------------------------------------
(define (length ls (l 0))
  (match ls
    ('() l)
    ((cons xH xT) (length xT (add1 l)))))
;A4--------------------------------------------------------
(define count 0)
(define (fib n)
  (set! count (add1 count))
  (if (< n 2)
      n
      (+ (fib (- n 1))
         (fib (- n 2)))))

(define (memoize fn)
  (define cache (make-hash))
    (lambda (arg) (hash-ref! cache arg (λ() (fn arg)))))


(define countfib 0)
(define (fib-mem n)
  (set! countfib (add1 countfib))
  (if (< n 2)
      n
      (+ (fib-mem (- n 1))
         (fib-mem (- n 2)))))


(set! fib-mem (memoize fib-mem)) ;;replace fib by the memoized fib function

(display "execution time (fib 30): ")
(time (void (fib 30)))

(display "numbers of invocations (fib 30): ")
(print count)
(display "\n \n")
(display "execution time with memoisation (fib 30): ")
(time (void (fib-mem 30)))
(display "number of invocations (fib 30): ")
(print countfib)
