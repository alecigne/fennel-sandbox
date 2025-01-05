(fn inc [x ?y]
  "Return the value of X incremented by 1, or by Y if provided."
  (+ x (or ?y 1)))

(fn dec [x ?y]
  "Return the value of X decremented by 1, or by Y if provided."
  (- x (or ?y 1)))

(macro incf [x ?by]
  "Increment X in-place by BY, if provided, or by 1."
  `(set ,x (inc ,x ,?by)))

(macro decf [x ?by]
  "Decrement X in-place by BY, if provided, or by 1."
  `(set ,x (dec ,x ,?by)))

(fn first [seq]
  "Return the first element of sequential table SEQ."
  (?. seq 1))

(fn last [seq]
  "Return the last element of sequential table SEQ."
  (?. seq (length seq)))

(fn nil? [x]
  "Check if X is nil."
  (= x nil))

(fn table? [x]
  "Check if X is a table."
  (= (type x) :table))

(macro unless [condition ...]
  `(when (not ,condition)
     ,...))

(fn half [x]
  "Return half of X."
  (/ x 2))

{: inc
 : dec
 : first
 : last
 : nil?
 : table?
 : half}
