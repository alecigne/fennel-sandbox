;; script:  fennel
;; strict:  true

(local u (require :lua/utils))

(fn center [str color]
  (let [width (print str 0 -6)]
    (print str (// (- 240 width) 2) (// (- 136 6) 2) color)))

(fn _G.TIC []
  (let [col (math.floor (/ (time) 100))]
    (cls col)
    (center "HELLO WORLD!!!" (u.inc col))))

;; <PALETTE>
;; 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
;; </PALETTE>
