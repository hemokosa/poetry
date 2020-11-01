; Interactive List Poetry for Raymond Roussel
;    by Akihiro Kubota (akihiro.kubota@nifty.com)

; quotes from William Burroughs and Laurie Anderson

(setf X '(LANGUAGE IS A VIRUS FROM OUTER SPACE))
(setf Y '(PARADISE IS EXACTLY LIKE WHERE YOU ARE RIGHT NOW))
(setf Z '(ONLY MUCH MUCH BETTER))

; insert-key

(defun insert-key (lst key ins)
  (push ins (cdr (member key lst))) lst)

(insert-key X 'VIRUS '(PLAN-9))
(insert-key X 'VIRUS '(COVID-19))
(insert-key (nth 5 X) 'PLAN-9 '(WORST DIRECTOR AND WORST FILM EVER))
(insert-key (nth 5 X) 'PLAN-9 '(ORIGINAL WINDOW SYSTEM IS CALLED |8-1/2|))
(insert-key (nth 1 (nth 5 X)) '|8-1/2| '(​1963 ITALIAN SURREALIST  COMEDY-DRAMA FILM DIRECTED BY FEDERICO FELLINI))
(insert-key (nth 4 X) 'COVID-19 Y)
(insert-key (nth 1 (nth 4 X)) 'PARADISE Z)

; reverse

(reverse X)

; flatten

(defun flatten (x)
  (labels ((rec (x acc)
                (cond ((null x) acc)
                      ((atom x) (cons x acc))
                      (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))

(flatten X)

(reverse (flatten X))

; Roussel Macro

(defun proto-roussel (tree leaf branch)
  (if tree
    (if (listp tree)
      (cons
        (proto-roussel (car tree) leaf branch)
        (proto-roussel (cdr tree) leaf branch))
      (if (funcall leaf tree)
        (funcall branch tree)
        tree))))

(defmacro roussel (tree leaf branch)
  `(proto-roussel
     ,tree
     (lambda (raymond)
       (declare (ignorable raymond))
       ,leaf)
     (lambda (raymond)
       (declare (ignorable raymond))
       ,branch)))

(setf A '(HOW I WROTE CERTAIN OF MY CODES))
(setf B '(IMPRESSIONS OF AFRICA))
(setf C '(LOCUS SOLUS))

(roussel A (equal raymond 'WROTE) (cons raymond B))
(roussel A (equal raymond 'WROTE) (cons raymond C))

; Lisp isn't a language, it's a building material. — Alan Kay

(setf L (roussel (roussel A (equal raymond 'WROTE) (cons raymond B)) (equal raymond 'WROTE) (cons raymond C)))
(setf I '(ARE NOT LANGUAGES))
(setf S '(ARE BUILDING MATERIALS))
(setf P (roussel L (equal raymond 'CODES) (cons raymond I)))

(setf RR (roussel P (equal raymond 'CODES) (cons raymond S)))

(flatten RR)
(reverse RR)
(reverse (flatten RR))
(flatten (reverse RR))
