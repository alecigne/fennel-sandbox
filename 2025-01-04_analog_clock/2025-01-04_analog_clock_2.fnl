;; script:  fennel
;; strict:  true

;; Maths

(fn half [x] (/ x 2))

;; Geometry

(fn point [x y] {: x : y })

(fn pline [p1 p2 color]
  (line p1.x p1.y p2.x p2.y color))

(fn rotate-orig [p deg]
  (let [rad (math.rad deg)
        cos (math.cos rad)
        sin (math.sin rad)]
    (point (+ (* p.x cos) (* p.y (- sin)))
           (+ (* p.y cos) (* p.x sin)))))

(fn rotate [p1 p2 deg]
  (let [p1o (point (- p1.x p2.x) (- p1.y p2.y))
        p2o (rotate-orig p1o deg)]
    (point (+ p2o.x p2.x)
           (+ p2o.y p2.y))))

;; Time

(fn utime []
  (math.floor (tstamp)))

;; Clock

(fn seconds->clock [seconds]
  (% seconds 43200))

(fn clock->geoclock [clock]
  (let [h (/ clock 3600)
        m (% (/ clock 60) 60)
        s (% clock 60)]
    {:hdeg (* (/ h 12) 360)
     :mdeg (* (/ m 60) 360)
     :sdeg (* (/ s 60) 360)}))

(fn draw-hand [deg center size color]
  (let [noon (point center.x (- center.y size))
        extremity (rotate noon center deg)]
    (pline center extremity color)))

(fn draw-clock [geoclock center size]
  (let [white 12
        light-grey 13]
    (circb center.x center.y size white)
    (draw-hand geoclock.hdeg center (- size 20) white)
    (draw-hand geoclock.mdeg center (- size 10) white)
    (draw-hand geoclock.sdeg center (- size 10) light-grey)))

;; Main

(local center (point (half 240) (half 136)))
(local clock-size 50)

(fn _G.TIC []
  (cls 8)
  (-> (utime)
      (seconds->clock)
      (clock->geoclock)
      (draw-clock center clock-size)))

;; <PALETTE>
;; 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
;; </PALETTE>
