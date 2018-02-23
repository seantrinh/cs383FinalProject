#define __SFR_OFFSET 0

#include "avr/io.h"
#include <avr/portpins.h>

;I pledge my honor that I have abided by the Stevens Honor System.
;Sean Trinh and Hariharan Vijayachandran

.text
.global setup
.global loop
.global one
.global light

setup:
  ldi r16, 0b11111111 ;Output (LEDs)
  ldi r17, 0b00000000 ;Input buttons
  out DDRB, r16 ;Initialize output pins
  out DDRD, r17 ;Initialize input pins
  ldi r19, 1 ;Computer's choice (Randomized)
  out PORTB, r17 ;Initialize LEDs
check:
  sbis PIND, 5 ;Check if rock button pressed
  brne rock  ;If pressed, go to rock
  sbis PIND, 6 ;Check if paper button pressed
  brne paper ;If pressed, go to paper
  sbis PIND, 7 ;Check if scissors button pressed
  brne scissors ;If pressed, go to scissors
  out PORTB, r17 ;Set the LEDs to all off
  jmp  loop ;Start the loop again
  
loop:
  cpi r19, 4 ;Compare to 4
  breq equal ;Go to equal
  call timer2 ;Time delay to enhance randomness
  inc r19 ;Increment r19
  jmp check ;Jump to check
equal:
  ldi r19, 1 ;Load r19 with 1
  jmp check ;Jump to check
rock:
  cpi r19, 1 ;Computer picked rock
  breq tie ;It is a tie, go to tie
  cpi r19, 2 ;Computer picked paper
  breq loser ;User loses, go to loser
  cpi r19, 3 ;Computer picked scissors
  breq winner ;User wins, go to winner

paper:
  cpi r19, 1 ;Computer picked rock
  breq winner ;User wins, go to winner
  cpi r19, 2 ;Computer picked paper
  breq tie ;It is a tie, go to tie
  cpi r19, 3 ;Computer picked scissors
  breq loser ;User loses, go to loser

scissors:
  cpi r19, 1 ;Computer picked rock
  breq loser ;User loses, go to loser
  cpi r19, 2 ;Computer picked paper
  breq winner ;User wins, go to winner
  cpi r19, 3 ;Computer picked scissors
  breq tie ;It is a tie, go to tie

winner:
  ldi r18, 0b11111001 ;Initialize LED to turn on
  out PORTB, r18 ;Output to port B
  call timer ;stay on for 1 second
  call timer ;stay on for 1 second
  call timer ;stay on for 1 second (3 seconds total)
  jmp check ;jmp gameover ;Restart the game

loser:
  ldi r18, 0b11111010 ;Initialize LED to turn on
  out PORTB, r18 ;Output to port B
  call timer ;stay on for 1 second
  call timer ;stay on for 1 second
  call timer ;stay on for 1 second (3 seconds total)
  jmp check ;jmp gameover ;Restart the game

tie:
  ldi r18, 0b11111100 ;Initialize LED to turn on
  out PORTB, r18 ;Output to port B 
  call timer ;stay on for 1 second 
  call timer ;stay on for 1 second NEW LINE
  call timer ;stay on for 1 second (3 seconds total)
  jmp check ;Restart the game 

timer: 
LDI r20, 50
L1: LDI r21, 255
L2: LDI r22, 255
L3:
  NOP
  NOP
  DEC R22
  BRNE L3
  DEC R21
  BRNE L2
  DEC R20
  BRNE L1

ret

timer2:
LDI r20, 20
L4: LDI r21, 150
L5: LDI r22, 150
L6:
  NOP
  NOP
  DEC R22
  BRNE L6
  DEC R21
  BRNE L5
  DEC R20
  BRNE L4

ret
  
  
  
