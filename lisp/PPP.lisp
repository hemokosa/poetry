(setq X '(LANGUAGE IS A VIRUS FROM OUTER SPACE))
(setq Y '(PARADISE IS EXACTLY LIKE WHERE YOU ARE RIGHT NOW))
(setq Z '(ONLY MUCH MUCH BETTER))

(setq X '(LANGUAGE IS A VIRUS FROM OUTER SPACE))

(defun insert-key (lst key ins)
    (push ins (cdr (member key lst)))
lst)

(insert-key X 'VIRUS '(PLAN-9))

(insert-key X 'VIRUS '(COVID-19))

(LANGUAGE IS A VIRUS (COVID-19) (PLAN-9) FROM OUTER SPACE)

(insert-key （nth 5 X) 'PLAN-9 '(WORST DIRECTOR AND WORST FILM EVER))


(WORST DIRECTOR AND WORST FILM EVER)
(ORIGINAL WINDOW SYSTEM IS CALLED 8-1/2)
(​1963 ITALIAN SURREALIST COMEDY-DRAMA FILM DIRECTED BY FEDERICO FELLINI)


(print '(Language is a Virus from Outer Space.))
(print (+ 2 3))

(defun insert-phrase (n k l)
  (cond ((atom l) (cons n nil))
        ((equal k (car l)) (cons (cons (car l) n) (cdr l)))
        (t (cons (car l) (insert-phrase n k (cdr l))))))

(defun insert-after (lst index newelt)
  (push newelt (cdr (nthcdr index lst) ) )
  lst)

(mapcar #'print X)

(LANGUAGE IS A VIRUS (COVID-19) FROM OUTER SPACE)

(LANGUAGE IS A VIRUS FROM OUTER SPACE)
(LISP)
(IS LOTS OF IRRITATING SUPERFLUOUS PARENTHESES)
(VIRUS)
(COVID-19)
(OUTER SPACE)
(PLAN-9 FROM OUTER SPACE)
(PLAN-9)
(WORST DIRECTOR AND WORST FILM EVER)
(PLAN-9 FROM BELL LABS)
(ORIGINAL WINDOW SYSTEM IS CALLED 8-1/2)
(​1963 ITALIAN SURREALIST COMEDY-DRAMA FILM DIRECTED BY FEDERICO FELLINI)

PARADISE
VIRUS
IS EXACTLY LIKE
WHERE YOU ARE RIGHT NOW
ONLY MUCH MUCH
BETTER
WORSE

(PARADISE IS EXACTLY LIKE WHERE YOU ARE RIGHT NOW)
(COVID-19)
(ONLY MUCH MUCH BETTER)

PLAN 9 WAS AN ATTEMPT TO DO UNIX OVER AGAIN, ONLY MUCH MUCH BETTER.
COVID-19 WAS AN ATTEMPT TO DO WORLD OVER AGAIN, ONLY MUCH MUCH BETTER.
PLAN-9 IS EXACTLY LIKE WHERE YOU ARE RIGHT NOW

THE MOST DANGEROUS ENEMY OF A BETTER WORLD IS AN EXISTING PARADICE THAT IS JUST GOOD ENOUGH


(defun insert-key (lst key ins)
    (push ins (cdr (member key lst)))
lst)

(defun insert-key (lst key ins)
    (if	(consp lst)
        (if (member key lst)
            (push ins (cdr (member key lst)))
        )
    )
lst)


(defun member2 (item lst)
  (if (null lst) nil
	(if (equal (car lst) item)
		t
	  (if (atom (car lst))
		  (member2 item (cdr lst))
		(or (member2 item (car lst))
			 (member2 item (cdr lst)))
		))))

(defun insert-key (lst key newelt)
  (subst 'HOGE key lst)
  (push newelt (cdr (member key lst)))
  lst)

; データをひとつリストに挿入
(defun insert-element (f n l)
  (cond ((atom l) (cons n nil))
        ((funcall f n (car l)) (cons n l))
        (t (cons (car l) (insert-element f n (cdr l))))))

; 挿入ソート
(defun insert-sort (f l)
  (if (atom l)
      nil
      (insert-element f (car l) (insert-sort f (cdr l)))))
