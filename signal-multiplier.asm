; ---------------------------------------
; ADDITION MODULE
; ---------------------------------------


mov 0, acc      ; reset total
sav             ; save total
mov up, right   ; move `a` into stack

loop:

mov left, acc   ; wait for a signal from counter
jez done        ; if zero, no more additions

addition:       ; not zero, need to perform addition

mov right, acc  ; pull `a` from stack
mov acc, right  ; save `a` back on stack for later
swp             ; get total
add right       ; pull `a` from stack and add
swp             ; save total
mov acc, right  ; save `a` back on stack for later
jmp loop        ; repeat

done:           ; nore more additions

mov right, nil  ; clear stack
swp             ; get saved total
mov acc, down   ; output total


; ---------------------------------------
; COUNTER MODULE
; ---------------------------------------

mov up, acc     ; get total

loop:           ; decrease counter until zero

jez done        ; quit if counter zero
sub 1           ; otherwise decrease counter
mov 1, right    ; tell addition module to add
jmp loop        ; repeat

done:           ; finished adding
mov 0, right    ; tell addition module to stop
