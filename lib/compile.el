(put 'if-let   'byte-obsolete-info nil)
(put 'when-let 'byte-obsolete-info nil)

(when (< emacs-major-version 30)
  (advice-add
   'internal--build-binding :around
   (lambda (fn binding prev-var)
     (let ((binding (funcall fn binding prev-var)))
       (if (eq (car binding) '_)
           (cons (make-symbol "s") (cdr binding))
         binding)))))
