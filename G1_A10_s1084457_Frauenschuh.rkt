#lang racket

;A1

(define (mc-eval exp [env null])      ;input: an expression and an (maybe empty) environment; goal: evaluate the expression in the environment
  (cond ((number? exp) exp)
        ((symbol? exp) (lookup-variable-value exp env))  ;to resolve variables and primitive functions
        ((pair? exp) (mc-apply (mc-eval (car exp) env) (list-of-values (cdr exp) env))) ;application: (operation operand1 operand2..)
        (else (error "Unknown expression type -- EVAL" exp))))


(define (mc-apply procedure arguments)     ;input: a procedure and its arguments; goal: apply the procedure to its arguments
  (cond ((tagged-list? procedure 'primitive) (apply-primitive-procedure procedure arguments))
        (else (error "Unknown procedure type -- APPLY" procedure))))


(define (lookup-variable-value var env)       ;input: a variable and an environment (i.e., a list of pairs); goal: get the value for this variable (since we have only primitive procedures, only one scope is required)
      (define val (assq var env))
      (if (eq? val false)
          (error "unbound variable" var)
          (cdr val)))

(define (list-of-values exps env)             ;input: a list of expressions and an environment; goal: turn the list of expressions into a list of values (by evaluating each expression in the environment) 
  (if (null? exps)
      '()
      (cons (mc-eval (car exps) env) (list-of-values (cdr exps) env))))

(define (tagged-list? exp tag)                ;input: an expression (a list that might start with tag) and a tag; goal: determine if the expression is a list that starts whose first element is tag
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (apply-primitive-procedure proc args)  ;input a procedure {e.g., '(primitive #<procedure:*>)} and arguments {e.g., '(1 2) }; goal: apply the procedure to the arguments
  (apply-in-underlying-racket (car (cdr proc)) args))

(define apply-in-underlying-racket apply) ;redirect to implementation language

;tests
(define my-env (list (cons 'num 999) (cons 'text "random") (cons 'num1 1) (cons 'num2 2) (cons 'true #t) (cons 'false #f) (cons '+ (list 'primitive +))))

(mc-eval 'num my-env)
(mc-eval 'text my-env)
(mc-eval '(+ num1 num2) my-env)
(mc-eval 'true my-env)
(tagged-list? (list 'tagged 1 2) 'test) ;#f
(tagged-list? (list 'tagged 3 4) 'tagged)  ;#t
(mc-apply (list 'primitive +) (list 1 2))

;A3

(define (mc-eval-a3 exp [env null])
    (cond
      ((number? exp) exp)
      ((boolean? exp) exp)
      ((symbol? exp) (lookup-variable-value exp env))
      ((pair? exp)
       (cond([eq? (car exp) 'or]
              (if (mc-eval (cadr exp) env) ;if first is true return true, else evaluate second value;
                 true
                 (mc-eval (caddr exp) env)))
            ([eq? (car exp) 'and]
              (if (mc-eval (cadr exp) env)  ;if first is true, evaluate second value, else return false
                  (mc-eval (caddr exp) env)
                  false))
             (else
              (mc-apply (mc-eval (car exp) env) (list-of-values (cdr exp) env))))) ;rest of pair? stays the same as before but as else expression
        (else (error "Unknown expression type -- EVAL" exp))))

(displayln "---------------")
(set! mc-eval mc-eval-a3)

(mc-eval '(or true false) my-env)
(mc-eval '(and true (and true false)) my-env)
(mc-eval '(or true (/ 0 0)) my-env) ;short circuit eval

;A4
;(mc-eval '(((lambda (x) (x x)) (lambda (x) (x x)))) null)
;source: VO Lambda Calculus on slide 23 (Recursion) -> "using a function which calls a function and then regenerates itself"
