#define __SFR_OFFSET 0
#include "avr/io.h" 
#include <avr/portpins.h> 
;Hariharan Vijayachandran, Sean Trihn
;I pledge my honor that I have abided by the Stevens Honor System
.text                                                         
        .global loop                                                          
        .global setup
        .global equal                                                     
        .global buttonpress
        .global one
        .global two
        .global three
        .global four
        .global five
        .global six                                                                      

setup:
ldi r16,0 ;Load r16 with 0
out DDRB, r16 ;Initialize port B
ldi r16,0b01111111 ;Initialize LEDs
out DDRD, r16 ;Initialize port D 
clr r16 ;Clear r16
ldi r17, 1 ;Load r17 with 1
check:
sbis PINB,0 ;Check if button pressed
jmp buttonpress ;Go to button press
jmp loop ;Go to loop
loop:
cpi r17, 7 ;Compare to 7
breq equal ;If equal, go to equal
inc r17 ;Increment r17
jmp check ;Go to check
equal:
ldi r17, 1 ;Load r17 with 1
jmp loop ;Go to loop
buttonpress:
cpi r17, 1 ;If 1, go to one
breq one
cpi r17, 2 ;If 2, go to two
breq two
cpi r17, 3 ;If 3, go to three
breq three
cpi r17, 4 ;If 4, go to four
breq four
cpi r17, 5 ;If 5, go to five
breq five
cpi r17, 6 ;If 6, go to six
breq six

one:

ldi r16,1 ;Load r16 with light
out PORTD, r16 ;Output to port D
jmp check ;Go to check
two:
ldi r16,0b00010010 ;Load r16 with lights
out PORTD, r16 ;Output to port D
jmp check ;Go to check
three:
ldi r16,0b00010011 ;Load r16 with lights
out PORTD, r16 ;Output to port D
jmp check ;Go to check
four:
ldi r16,0b01011010 ;Load r16 with lights
out PORTD, r16 ;Output to port D
jmp check ;Go to check
five:
ldi r16,0b01011011 ;Load r16 with lights
out PORTD, r16 ;Output to port D
jmp check ;Go to check
six:
ldi r16,0b01111110 ;Load r16 with lights
out PORTD, r16 ;Output to port D
jmp check ;Go to check


