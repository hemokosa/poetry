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



(defun replace-nth (list n elem)
  (cond
    ((null list) ())
    ((= n 0) (cons elem list))
    (t (cons (car list) (replace-nth (cdr list) (1- n) elem)))))


; Roussel Macros

(setq R '(HOW I WROTE CERTAIN OF MY CODES))

(defmacro ROUSSELR (ACIRFA)
    (list 'reverse ACIRFA))

(defmacro ROUSSELR (ACIRFA)
    `(reverse ,ACIRFA))

(defmacro noisy-second (x)
  `(progn
     (princ "Someone is taking a cadr!")
     (cadr ,x)))


(defun tree-leaves%% (tree test result)
  (if tree
    (if (listp tree)
      (cons
        (tree-leaves%% (car tree) test result)
        (tree-leaves%% (cdr tree) test result))
      (if (funcall test tree)
        (funcall result tree)
        tree))))


(defmacro tree-leaves (tree test result)
  `(tree-leaves%%
     ,tree
     (lambda (x)
       (declare (ignorable x))
       ,test)
     (lambda (x)
       (declare (ignorable x))
       ,result)))

(tree-leaves
    '(1 2 (3 4 (5 6)))
    (and (numberp x) (evenp x))
    'even-number)

(tree-leaves
    R
    (equal x 'WROTE)
    (list x '(ZZZ)))

(tree-leaves R (equal x 'WROTE) (list x '(ZZZ)))

(defun insert (lst ins)
  (push ins (cdr lst))
  lst)

(defun roussel% (tree test result)
  (if tree
    (if (listp tree)
      (cons
        (roussel% (car tree) test result)
        (roussel% (cdr tree) test result))
      (if (funcall test tree)
        (funcall result tree)
        tree))))

(defmacro roussel (tree test result)
  `(roussel%
     ,tree
     (lambda (raymond)
       (declare (ignorable raymond))
       ,test)
     (lambda (raymond)
       (declare (ignorable raymond))
       ,result)))

(roussel R (equal raymond 'WROTE) (cons x '(ZZZ)))


(setq R '(HOW I WROTE CERTAIN OF MY CODES))
(setq A '(IMPRESSIONS OF AFRICA))
(setq S '(LOCUS SOLUS))
(setq L '(ARE NOT LANGUAGES))
(setq M '(ARE BUILDING MATERIALS))


(roussel R (equal raymond 'WROTE) (cons raymond A))
(roussel (roussel R (equal raymond 'WROTE) (cons raymond A)) (equal raymond 'WROTE) (cons raymond S))

(setq Q '(HOW I ((WROTE LOCUS SOLUS) IMPRESSIONS OF AFRICA) CERTAIN OF MY CODES))

(setq P (roussel Q (equal raymond 'CODES) (cons raymond L)))
(roussel P (equal raymond 'CODES) (cons raymond M))
