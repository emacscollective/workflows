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

(when (< emacs-major-version 30)
  (require 'subr-x) ;for when-let*
  (advice-add
   'check-declare-directory :override
   (lambda (root)
     (interactive "DDirectory to check: ")
     (setq root (directory-file-name (file-relative-name root)))
     (or (file-directory-p root)
         (error "Directory `%s' not found" root))
     (when-let* ((files (directory-files-recursively root "\\.el\\'"))
                 (files (mapcan (lambda (file)
                                  ;; Filter out lock files.
                                  (and (not (string-prefix-p
                                             ".#" (file-name-nondirectory file)))
                                       (list file)))
                                files)))
       (apply #'check-declare-files files)))))
