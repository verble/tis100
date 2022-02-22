
; FILLER
; adds inputs to first stack

mov 0, right     ; fill with four zeros on start so stack always has 5
mov 0, right
mov 0, right
mov 0, right

loop:

mov left, right  ; add next input
mov 5, down      ; send ready signal, which is also counter start
mov down, nil    ; wait for ready signal
jmp loop         ; repeat

; ELIMINATOR / STREAMER
; sends last five elements to adders and removes oldest
; element in stack

start:

mov left, acc    ; wait for ready signal, which is also counter start

loop:

jez reverse      ; begin reverse/send
sub 1            ; decrease counter
mov up, down     ; send to second stack
jmp loop         ; repeat

reverse:

mov down, left   ; send last element, don't put back in first stack
mov 4, acc       ; set counter to four

loop2:

jez start        ; done reversing
swp
mov down, acc    ; get next
mov acc, left    ; send to forwarders
mov acc, up      ; send to first stack
swp
sub 1            ; decrease counter
jmp loop2        ; repeat


; ADDER-FORWARDER
; sends groups of 3 and 5 inputs to adders

mov up, right    ; forward ready signal from filler to eliminator

mov right, down   ; send 5th latest to 5-adder
mov right, down   ; send 4th latest to 5-adder
mov right, acc    ; send 3rd latest to 5-adder and 3-adder
mov acc, down
mov acc, left
mov right, acc    ; send 2nd latest to 5-adder and 3-adder
mov acc, down
mov acc, left
mov right, acc    ; send 1st latest to 5-adder and 3-adder
mov acc, down
mov acc, left

mov 0, up        ; send ready signal to filler
