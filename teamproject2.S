#define __SFR_OFFSET 0

#include "avr/io.h"
#include <avr/portpins.h>

;Sean Trinh and Hariharan Vijayachandran
;I pledge my honor that I have abided by the Stevens Honor System.

.text
.global setup
.global loop
.global timer

setup:
  ldi r16, 0b00001110 ;Initialize output pins
  out DDRD, r16 ;Use port D
  clr r16 ;Clear r16
loop:
ldi r16, 0 ;Load r16 with 0
ldi r17, 0b00000010 ;Initialize red light
out PORTD, r17 ;Output to port D
ldi r17, 0b00001000 ;Initialize green light
red: cpi r16, 10 ;Loop ten seconds
        breq beforegreen ;Go to beforegreen
       call timer ;timer one second
       inc r16 ;Increment r16
       jmp red ;Start the loop again
beforegreen:
  ldi r16, 0 ;Load r16 with 0
  out PORTD, r17 ;Output to port D
  ldi r17, 0b00000100 ;Initialize yellow light
green:
  cpi r16, 7 ;Loop 7 seconds
  breq yellow ;Go to yellow
  call timer ;timer one second
  inc r16 ;Increment r16
  jmp green ;Start the loop again
   
yellow:
  out PORTD, r17 ;Output to port D
  call timer ;timer 1 second
  call timer ;timer 1 second (total 2 seconds)
  jmp loop ;Start the entire loop again

timer: 
LDI r19, 50
L1: LDI r20, 255
L2: LDI r21, 255
L3:
  NOP
  NOP
  DEC R21
  BRNE L3
  DEC R20
  BRNE L2
  DEC R19
  BRNE L1

ret
