(defpackage #:cl-redis-bench
  (:use #:cl #:redis)
  (:export #:bench-ping))

(in-package #:cl-redis-bench)

(defun bench-ping (&optional (repeat 100000))
  (with-connection ()
    (format t "Ping ~a times without pipelining...~%" repeat)
    (time (dotimes (i repeat)
            (red-ping)))
    (format t "Ping ~a times with pipelining...~%" repeat)
    (time (with-pipelining
            (dotimes (i repeat)
              (red-ping))))
    t))
