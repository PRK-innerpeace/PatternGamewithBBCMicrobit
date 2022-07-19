.syntax unified
@ Simple timer library
@ NOTE: This module depends on utils.S and symbols.S

@ --------------------- Module Interface --------------------
@ declare all labels corresponding to functions designed to be called from elsewhere
@ as global - this is the public API of the library
@ Function exports:
.global init_timer

 
@ --------------------- Implementation --------------------
.type init_timer, %function
@ REQUIRED for other functions in this library to work (call once)
@ Sets the GPIO pins used for the led matrix to OUTPUT mode 
@ --parameters--
@ none
init_timer:
  push {lr}
 @ mode = 1 Set the timer in Counter Mode
  ldr r0, =ADR_TIMER0
  ldr r2, =OFS_TIMER_MODE
  add r2,r0
  mov r1,0
  str r1,[r2]
 @clear timer
  ldr r2, =OFS_TIMER_TASKS_CLEAR
  add r2,r0
  mov r1,1
  str r1,[r2]

 @Set prescaler. Higher number gives slower timer. Prescaler = 0 gives 16MHz timer
  ldr r2, =OFS_TIMER_PRESCALER
  add r2,r0
  mov r1,4
  str r1,[r2]
 @Set counter to 16 bit resolution
  ldr r2, =OFS_TIMER_BITMODE
  add r2,r0
  mov r1,3
  str r1,[r2]
 @Set value for TIMER2 compare register 0
  ldr r2, =OFS_TIMER_CC0
  add r2,r0
  ldr r1,=2000
  str r1,[r2]

  @Enable interrupt on Timer 0, for CC[0]
  ldr r2, =OFS_TIMER_ITENSET
  add r2,r0
  ldr r1,=(1<<16)
  str r1,[r2]
  @Enable nvic
    ldr r0, =ADR_NVIC
    ldr r2,=OFS_NVIC_ISER0
    add r2,r0
    ldr r1, =(1 << 8) @ set the 8th bit since NVIC_TIMER_ID = 8
    str r1, [r2] 
 @start timer
  ldr r0, =ADR_TIMER0
  ldr r2, = OFS_TIMER_TASKS_START
  add r2,r0
  mov r1,1
  str r1,[r2]



 @ mode = 1 Set the timer in Counter Mode
  ldr r0, =ADR_TIMER1
  ldr r2, =OFS_TIMER_MODE
  add r2,r0
  mov r1,0
  str r1,[r2]
 @clear timer
  ldr r2, =OFS_TIMER_TASKS_CLEAR
  add r2,r0
  mov r1,1
  str r1,[r2]

 @Set prescaler. Higher number gives slower timer. Prescaler = 0 gives 16MHz timer
  ldr r2, =OFS_TIMER_PRESCALER
  add r2,r0
  mov r1,4
  str r1,[r2]
 @Set counter to 32 bit resolution
  ldr r2, =OFS_TIMER_BITMODE
  add r2,r0
  mov r1,3
  str r1,[r2]
 @Set value for TIMER1 compare register 0
  ldr r2, =OFS_TIMER_CC0
  add r2,r0
  ldr r1,=10000
  str r1,[r2]

  @Enable interrupt on Timer 1, for CC[0]
  ldr r2, =OFS_TIMER_ITENSET
  add r2,r0
  ldr r1,=(1<<16)
  str r1,[r2]
  @Enable nvic
    ldr r0, =ADR_NVIC
    ldr r2,=OFS_NVIC_ISER0
    add r2,r0
    ldr r1, =(1 << 9) @ set the 8th bit since NVIC_TIMER_ID = 8
    str r1, [r2] 


  pop {lr}
  bx lr

.size init_timer, .-init_timer


