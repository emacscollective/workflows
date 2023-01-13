(setq backtrace-line-length 0)

(defun msg (format-string &rest args)
  (let ((output (apply #'format format-string args)))
    (princ output)
    (unless (string-suffix-p "\n" output)
      (princ "\n"))))

(defalias 'log #'message)

(defun err (format-string &rest args)
  (apply #'message format-string args)
  (throw 'return 1))

(defun run (&rest args)
  (let (status output)
    (with-temp-buffer
      (setq status (apply #'call-process (car args) nil t nil (cdr args)))
      (setq output (buffer-substring-no-properties (point-min) (point-max))))
    (msg "%s" output)
    (unless (zerop status)
      (throw 'return status))))
