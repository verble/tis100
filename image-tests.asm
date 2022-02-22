; ROW COUNTER

mov acc, down
add 1          ; increase counter


; OUTPUT FORMATTER

mov 0, down    ; send column number (always 0)
mov up, down   ; receive row counter and send out
mov 29, acc    ; screen is 30 wide

col:

jlz row        ; if counter is negative, done with row
mov 3, down    ; draw white
sub 1          ; decrease counter
jmp col        ; repeat

row:

mov -1, down   ; send terminator

; ----------------------------------------------------
; ----------------------------------------------------
; ----------------------------------------------------


; ROW COUNTER

mov acc, down
add 1          ; increase counter


; OUTPUT FORMATTER

mov 0, down    ; send column number (always 0)
mov up, down   ; receive row counter and send out
mov 29, acc    ; screen is 30 wide

col:

jlz row        ; if counter is negative, done with row
mov left, down ; draw next color in pattern sequence
sub 1          ; decrease counter
jmp col        ; repeat

row:

mov -1, down   ; send terminator
mov left, nil  ; advance pattern sequence

; PATTERN SEQUENCER

mov 3, right
mov 0, right


; ----------------------------------------------------
; ----------------------------------------------------
; ----------------------------------------------------


; INPUT FORMATTER
; recieves x, y, width, height

mov up, down   ; send x to x calculator
mov up, right  ; send y to ys calculator
mov up, left   ; send width to width calculator
mov up, acc    ; get height
mov acc, down  ; send height to all calculators
mov acc, right
mov acc, left


; YS CALCULATOR
; receives a (y, height) tuple and outputs y coords for each line

start:

mov left, acc    ; get y coordinate and store
swp
mov left, acc    ; get height and store as counter

loop:

jez start      ; counter is zero, done with rectangle
swp            ; access y coord
mov acc, down  ; send y coord
add 1          ; increase y coord
swp            ; access counter
sub 1          ; decrease counter
jmp loop       ; repeat


; XS CALCULATOR
; recieves a (x, height) tuple and outputs x coords for each line

start:

mov up, acc    ; get x coordinate and store
swp
mov up, acc    ; get height and store as counter

loop:

jez start      ; counter is zero, done with rectangle
swp            ; access x coordinate
mov acc, down  ; send x coord
swp            ; access counter
sub 1          ; decrese counter
jmp loop       ; repeat


; WIDTH CALCULATOR
; recieves a (width, height) tuple and outputs x coords for each line

start:

mov right, acc ; get width and store
swp
mov right, acc ; get height and store as counter

loop:

jez start      ; counter is zero, done with rectangle
swp            ; access width
mov acc, down  ; send width
swp            ; access counter
sub 1          ; decrese counter
jmp loop       ; repeat


; OUTPUT FORMATTER
; receives (x, y, width) tuples and draws white lines

mov left, down ; receive and send x coordinate
mov up, down ; receive and send y coordinate
mov left, acc  ; recieve width

loop:
jez done     ; if zero, finished drawing line
mov 3, down  ; draw white
sub 1        ; decrease counter
jmp loop     ; repeat

done:
mov -1, down ; send terminator



; ----------------------------------------------------
; ----------------------------------------------------
; ----------------------------------------------------


; X COUNTER
; sends current x value
; also converts height from input to starting-y and sends

mov acc, down  ; send x value
add 1          ; increment x value
swp            ; save x value
mov 18, acc    ; height of screen
sub up         ; subtract height of bar from height of screen (= y-start)
mov acc, down  ; send y-start
swp            ; access x value



; OUTPUT FORMATTER
; takes (x, height) tuples and outputs vertical lines

; has to store current y and current x

start:

mov up, acc    ; get x value
swp            ; store x value
mov up, acc    ; get y-start as counter

loop:

sub 18         ; counter - 18
jez start      ; if zero, that means counter = 18 and we are done
add 18         ; if not, restore counter's value and continue

send:

swp            ; access x value
mov acc, down  ; send x
swp            ; access y value
mov acc, down  ; send y value
add 1          ; increase y value
mov 3, down    ; send white
mov -1, down   ; send terminator
jmp loop       ; repeat


