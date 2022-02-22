

; SEGMENTS
;
;                       V
;     []        [INPUT FORMATTER] -> [LOGIC] <-> [MAXIMIZER]
;                       V              V
; [MINIMIZER] <->  [LOGIC]        [FORWARDER]        [!]
;                     V              V
;     []          [FORWARDER]     [FORWARDER]        []
;                     V              V




; INPUT FORMATTER MODULE
; Takes a stream of inputs.
; Produces two streams of outputs.
; Sends the first number once to both outputs. Then, while the next
; input is not zero, sends the doubled input to both outputs. Once a zero
; is encountered it sends zero once to both outputs.
; Repeat indefinately.

start:
mov up, acc     ; get the first number in the sequence
mov acc, right  ; send the first number
mov acc, down

loop:
mov up, acc     ; get next number
jez done        ; if zero sequence has ended

duplicate:      ; need to send duplicates for benefit of logic modules
mov acc, right  ; send once
mov acc, down
mov acc, right  ; send twice
mov acc, down
jmp loop        ; go to end of sequence test

done:           ; sequence is over
mov nil, right  ; send zero and repeat
mov nil, down


; MAXIMIZER MODULE
; Takes two inputs with the second duplicated (a, b, b).
; Returns one output.
; Returns the larger of the two inputs.

start:
mov left, acc   ; get first number
sav             ; save it
sub left        ; subtract the second number from the first
jgz larger      ; first number is larger

smaller:        ; first number is smaller
mov left, left  ; take repeated input and return it
jmp start       ; repeat

larger:         ; first number is larger
mov left, nil   ; discard repeated input
swp             ; restore first number
mov acc, left   ; return first number, repeat


; MINIMIZER MODULE
; Takes two inputs with the second duplicated (a, b, b).
; Returns one output.
; Returns the smaller of the two inputs.

start:
mov left, acc   ; get first number
sav             ; save it
sub left        ; subtract the second number from the first
jgz larger      ; first number is larger

smaller:        ; first number is smaller
mov left, nil   ; discard repeated input
swp             ; restore first number
mov acc, left   ; return first number
jmp start       ; repeat

larger:         ; first number is larger
mov left, left  ; take repeated input and return it, repeat


; STORE / SEND MODULE
; DETECTS WHEN THE SEQUENCE HAS ENDED
; AND SENDS SAVED NUMBER TO OUTPUT

start:          ; at start there is no saved number
mov left, acc   ; get the first number
sav             ; backup number and continue to LOOP

loop:           ; for each number in sequence
mov left, acc   ; get next number
jez endofseq    ; if zero, sequence has ended

compare:        ; if not zero, need to compare with saved number
mov acc, right  ; send new number to comparision module
swp             ; get old number
mov acc, right  ; send old number to comparision module
mov acc, right  ; send again (comparision module needs duplicate arg)
mov right, acc  ; get result from comparision module
sav             ; save updated result
jmp loop        ; repeat

endofseq:       ; at end of sequence
swp             ; restore saved maximum
mov acc, down   ; pass maximum to output node, return to start
