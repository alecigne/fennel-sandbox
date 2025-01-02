(fn inc [x ?y]
  "Return the value of X incremented by 1, or by Y if provided."
  (+ x (or ?y 1)))

(fn dec [x ?y]
  "Return the value of X decremented by 1, or by Y if provided."
  (- x (or ?y 1)))

(fn first [seq]
  "Return the first element of sequential table SEQ."
  (?. seq 1))

(fn last [seq]
  "Return the last element of sequential table SEQ."
  (?. seq (length seq)))

{: inc
 : dec
 : first
 : last}
