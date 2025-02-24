;; script:  fennel
;; strict:  true

(local u (require :lua/utils))

;;; Geometry

(fn point [x y]
  "Build a point in the plane, with coordinates X,Y"
  {: x : y})

(fn iline [p1 p2 col]
  (line p1.x p1.y p2.x p2.y col))

(fn rotate-orig [p deg]
  "Rotate P around the origin by DEG degrees, counterclockwise."
  (let [rad (math.rad deg)
        cos (math.cos rad)
        sin (math.sin rad)]
    (point (+ (* p.x cos) (* p.y (- sin)))
           (+ (* p.y cos) (* p.x sin)))))

(fn rotate [p1 p2 deg]
  "Rotate P1 around P2 by DEG degrees, counterclockwise.
Rotation is done relative to the origin, then translated to its final place."
  (let [p1o (point (- p1.x p2.x) (- p1.y p2.y))
        p2o (rotate-orig p1o deg)]
    (point (+ p2o.x p2.x)
           (+ p2o.y p2.y))))

;;; Time

(fn utime []
  "Return the current UNIX timestamp."
  (math.floor (tstamp)))

(λ ltime [h m s ?z]
  "Build a local time in the H:M:S format, with an optional offset Z."
  {:h (% h 24) :m (% m 60) :s (% s 60) :z (or ?z 0)})

(fn ltime->string [ltime]
  "Convert a local time LTIME into a string."
  (string.format "%02dh%02dm%02ds UTC+%g" ltime.h ltime.m ltime.s ltime.z))

(λ utime->ltime [utime ?z]
  "Convert a UNIX timestamp into a local time."
  (let [utime (+ utime (* 3600 (or ?z 0)))]
    (ltime (% (math.floor (/ utime 3600)) 24)
           (% (math.floor (/ utime 60)) 60)
           (% utime 60)
           ?z)))

(fn ltime->clock [ltime]
  "Build an analog clock from a local time LTIME."
  (let [sec (+ (* 3600 ltime.h) (* 60 ltime.m) ltime.s)]
    {:h (% (/ sec 3600) 12)
     :m (% (/ sec 60) 60)
     :s (% sec 60)}))

;;; Clock

(fn clock->geoclock [clock]
  "Convert a clock into a 'geometrical clock': 3 components expressed in
degrees."
  {:h (* (/ clock.h 12) 360)
   :m (* (/ clock.m 60) 360)
   :s (* (/ clock.s 60) 360)})

(fn draw-clock [ltime pos radius]
  "Draw a clock from a local time LTIME, a position POS and a radius RADIUS."
  (local geoclock (-> (ltime->clock ltime) (clock->geoclock)))
  (local noon (point pos.x (+ (- pos.y radius) (/ radius 5))))
  (circb pos.x pos.y radius 10)
  (each [_ angle (pairs geoclock)] (iline pos (rotate noon pos angle) 12))
  (circ pos.x pos.y (/ radius 20) 10))

(local center (point (u.half 240) (u.half 136)))

(fn _G.TIC []
  (cls 8)
  (let [ltime (utime->ltime (utime) 1)]
    (print (ltime->string ltime) 10 10 12)
    (draw-clock ltime center 50)))

;; <PALETTE>
;; 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
;; </PALETTE>
