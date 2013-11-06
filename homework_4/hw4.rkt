
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod : negative number")]
        [(null? xs) (error "list-nth-mod : empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

(define (stream-for-n-steps s n)
  (cond [(= n 0) null]
        [#t (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))]))

(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (modulo x 5) 0) (- x) x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define dan-then-dog
  (letrec ([f (lambda (x) (cons (if (= x 0) "dan.jpg" "dog.jpg") (lambda () (f (modulo (+ x 1) 2)))))])
    (lambda () (f 0))))

(define (stream-add-zero s)
  (letrec ([f (lambda (x) (cons (cons 0 (car (x))) (lambda () (f (cdr (x))))))])
    (lambda () (f s))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (i) (cons (cons (list-nth-mod xs i) (list-nth-mod ys i)) (lambda () (f (+ i 1)))))])
    (lambda () (f 0))))

(define (vector-assoc v vec)
  (letrec ([f (lambda (i) 
                (cond [(= (vector-length vec) i) #f]
                      [(pair? (vector-ref vec i)) 
                       (if (equal? (car (vector-ref vec i)) v)
                           (vector-ref vec i)
                           (f (+ i 1)))]
                      [#t (f (+ i 1))]))])
    (f 0)))


(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [counter 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v memo)])
                      (if ans
                          ans
                          (let ([new (assoc v xs)])
                                (begin
                                  (vector-set! memo counter new)
                                  (set! counter (modulo (+ counter 1) n))
                                  new)))))])
    f))

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([a e1]
              [f (lambda ()
                   (if (>= e2 a)
                       #t
                       (f)))])
       (f))]))