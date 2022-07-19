.syntax unified
@ Simple button library
@ NOTE: This module depends on utils.S and symbols.S

@ --------------------- Module Interface --------------------
@ declare all labels corresponding to functions designed to be called from elsewhere
@ as global - this is the public API of the library
@ Function exports:
.global init_buttons

 
@ --------------------- Implementation --------------------
.type init_buttons, %function
@ REQUIRED for other functions in this library to work (call once)
@ Sets the GPIO pins used for the led matrix to OUTPUT mode 
@ --parameters--
@ none
init_buttons:
  push {lr}
@ 1: Configure GPIOTE_CONFIG[0] (Section 6.9.4.8 in nRF52833 ref
 @ mode = 1 (event), pin = 14 and port = 0 (P0.14 = Button A),Generate IN[0] event when rising edge on pin.

  ldr r0, =ADR_GPIOTE
  ldr r2, =OFS_GPIOTE_CONFIG0
  add r2,r0
  ldr r1, =(1 | 14 << 8 | 0 << 13 | 2 << 16)
  str r1, [r2]

  @ mode = 1 (event), pin = 23 and port = 0 (P0.23 = Button B),Generate IN[1] event when rising edge on pin.
  ldr r2,=OFS_GPIOTE_CONFIG1
  add r2,r0
  ldr r1, =(1 | 23 << 8 | 0 << 13 | 2 << 16)
  str r1, [r2]

@ mode = 1 (event), pin = 4 and port = 1(P1.04 = Touch Logo),Generate IN[2] event when rising edge on pin.
 ldr r2,=OFS_GPIOTE_CONFIG2
 add r2,r0
 ldr r1, =(1 | 4 << 8 | 1 << 13 | 2 << 16)
 str r1, [r2]
@ 2: Enable Interrupt for GPIOTE[0] (id = 6) (S6.9.4.6 in nRF528
 ldr r2,=OFS_GPIOTE_INTENSET
 add r2,r0
 ldr r1, =(1<<0| 1<<1|1<<2) @enable interrupts on channel 0 and 1,2
 str r1, [r2]
@ 3: enable GPIOTE (interrupt #6 = NVIC_GPIOTE_ID) in NVIC_ISER0
 ldr r0, =ADR_NVIC
 ldr r2,=OFS_NVIC_ISER0
 add r2,r0
 ldr r1, =(1 << 6) @ set the 6th bit since NVIC_GPIOTE_ID = 6
 str r1, [r2] 


  pop {lr}
  bx lr
.size init_buttons, .-init_buttons


