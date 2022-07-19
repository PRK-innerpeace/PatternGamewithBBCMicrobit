.syntax unified
.global main



.type main, %function
main:
  @initialization of systick
  ldr r0,=ADR_SYST_CSR
  ldr r1,=0b111
  str r1,[r0]
  
  ldr r0,=ADR_SYST_RVR
  ldr r1,=64000
  str r1,[r0]
 
 bl init_timer
 bl init_buttons
 bl init_leds
 bl start_sound




loop:




  ldr r1,=flag_bit
  ldr r2,[r1]
  cmp r2,1
  beq button_A_pressed
  ldr r2,[r1,4]
  cmp r2,1
  beq button_B_pressed
  ldr r2,[r1,8]
  cmp r2,1
  beq touch_pressed

  b loop

touch_pressed:
  ldr r1,=flag_bit
  mov r2,0
  str r2,[r1,8]
  
@first you need to see your level
  ldr r1,=level_counter
  ldr r2,[r1]
  cmp r2,#5
  bgt end_swich
  cmp r2,#5
  beq Case5
  cmp r2,#4
  beq Case4
  cmp r2,#3
  beq Case3
  cmp r2,#2
  beq Case2
  cmp r2,#1
  beq Case1
  cmp r2,#0
  beq Case0
Case0:
  nop
  bl show_level_image_0
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_0
  Case0_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case0_loop
  b input_right


Case1:
  bl show_level_image_1
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_1
  Case1_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case1_loop
  b input_right




Case2:

  bl show_level_image_2
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_2
  Case2_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case2_loop
  b input_right





Case3:

  bl show_level_image_3
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_3
  Case3_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case3_loop
  b input_right

  
  



Case4:

  bl show_level_image_4
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_4
  Case4_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case4_loop
  b input_right

  



Case5:

  bl show_level_image_5
  ldr r5,=input_counter
  ldr r3,[r5]
  mov r10,0
  ldr r6,=your_input_position
  ldr r7,=level_image_5
  Case5_loop:
  ldr r2,[r6,r10,lsl 2]
  ldr r1,[r7,r10,lsl 2]
  cmp r1,r2
  bne input_error  
  add r10,1  
  cmp r10,r3
  bne Case5_loop
  b Congratulation


  
  
end_swich:
 b loop
Congratulation:
  bl show_right_image
  ldr r1,=level_counter
  mov r0,0 
  str r0,[r1]  
  @sound for right
  bl right_sound
  bl show_level_image_6
  bl show_level_image_7
  bl show_level_image_8
  bl start_sound
  @restart your input 
  ldr r1,=input_counter
  mov r0,0
  str r0,[r1]

  b loop
input_right:
  bl show_right_image
  ldr r1,=level_counter
  ldr r0,[r1]
  add r0,1
  str r0,[r1]  
  @sound for right
  bl right_sound
  @restart your input 
  ldr r1,=input_counter
  mov r0,0
  str r0,[r1]

  b loop

input_error:
  bl show_error_image
 @sound for error
  bl wrrong_sound
 @restart your input 
  ldr r1,=input_counter
  mov r0,0
  str r0,[r1]
  b loop


button_A_pressed:
  bl sound_check
  ldr r1,=current_position
  ldr r2,[r1]
  ldr r1,=input_counter
  ldr r0,[r1]
  ldr r1,=your_input_position
  str r2,[r1,r0,lsl #2]
  add r0,1
  ldr r1,=input_counter
  str r0,[r1]
  ldr r1,=flag_bit
  mov r2,0
  str r2,[r1]
  b loop


button_B_pressed:
  ldr r1,=flag_bit
  mov r2,0
  str r2,[r1,4]
 
 
 ldr r4,=current_position
 ldr r5,[r4]
 mov r10,5

 udiv r2,r5,r10
 mul r6,r10,r2
 sub r1,r5,r6
 push {r1}
 ldr r3,=led_matrix_row
 ldr r0,[r3,r2,lsl #2]
 bl write_row_pins
 ldr r3,=led_matrix_column
 pop {r1}
 ldr r0,[r3,r1,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,25
 beq init_led_matrix 

 str r5,[r4]
 b loop
 init_led_matrix:
 mov r5,0 
 str r5,[r4]
 b loop



.size main, .-main




.global GPIOTE_IRQHandler
.type GPIOTE_IRQHandler, %function
GPIOTE_IRQHandler:
 @ interrupt code goes here
 @ clear event
 @when event occured in Associated pin then set this bit and we check it  this is for channel 0
 @after check it you must clear thi bit otherwise this interrupt handler will be always working
 push {r4,r5}
  @ start timer
  ldr r4, =ADR_TIMER1
  ldr r5, =OFS_TIMER_TASKS_CLEAR
  add r5,r4
  mov r1,1
  str r1,[r5] 
  ldr r0, =ADR_TIMER1
  ldr r2, = OFS_TIMER_TASKS_START
  add r2,r0
  mov r1,1
  str r1,[r2]

 ldr r4, =ADR_GPIOTE
 ldr r5, =OFS_GPIOTE_EVENTS_IN0
 add r5,r4
 @after check it you must clear thi bit otherwise this interrupt handler will be always working
 mov r1,0
 str r1,[r5]

 @when event occured in Associated pin then set this bit and we check it  this is for channel 1
 ldr r5,=OFS_GPIOTE_EVENTS_IN1
 add r5,r4
 mov r1,0
 str r1, [r5]

 ldr r5,=OFS_GPIOTE_EVENTS_IN2
 add r5,r4
 ldr r0,[r5]
 ldr r4,=flag_bit
 str r0,[r4,8]
 mov r1,0
 str r1, [r5]

 pop {r4,r5}
 bx lr
 

.size GPIOTE_IRQHandler, .-GPIOTE_IRQHandler 



.global TIMER1_IRQHandler
.type TIMER1_IRQHandler, %function
TIMER1_IRQHandler:
 push {r4,r5}
 ldr r4, =ADR_TIMER1
 ldr r5, =OFS_TIMER_TASKS_CLEAR
 add r5,r4
 mov r1,1
 str r1,[r5] 
 ldr r5, =OFS_TIMER_TASKS_STOP
 add r5,r4
 mov r1,1
 str r1,[r5] 


 @p0.14  is button A
 @p0.23  is button B
 @p1.04  is touch logo
 ldr r4,=ADR_P0
 ldr r5,=OFS_GPIO_IN
 add r5,r4
 ldr r1,[r5]
 mov r0,0x84
 lsl r0,16
 cmp r0,r1
 beq button_A_flag
 mov r0,0x11
 lsl r0,14
 cmp r0,r1
 beq button_B_flag


 b end_handler

button_A_flag:
 ldr r4,=flag_bit
 mov r0,1
 str r0,[r4]
b end_handler
button_B_flag:
 ldr r4,=flag_bit
 mov r0,1
 str r0,[r4,4]

end_handler:
 @after check it you must clear thi bit otherwise this interrupt handler will be always working
 ldr r4, =ADR_TIMER1
 ldr r5,=OFS_TIMER_EVENTS_COMPARE0
 add r5,r4
 mov r1,0
 str r1,[r5]
 
 pop {r4,r5}
 bx lr



.size TIMER1_IRQHandler, .-TIMER1_IRQHandler




@ .type init_led_matrix,%function
@ init_led_matrix:
@ mov r5,0
@ bx lr

@ .size init_led_matrix,.-init_led_matrix
.data
flag_bit: @ flag bit for button a ,b and touch
.word 0,0,0

current_position:
.word 0

your_input_position:
.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
input_counter:
.word 0
level_counter:
.word 0

led_matrix_column:
.word 0b11110,0b11101,0b11011,0b10111,0b01111
led_matrix_row:
.word 0b00001,0b00010,0b00100,0b01000,0b10000
@small square
level_image_0:
.word 7,9,17,19
@eye pattern
level_image_1:
.word 7,8,9,11,13,15,17,18,19
@cup pattern
level_image_2:
.word 1,5,7,8,9,13,18,22,23,24
@clock pattern
level_image_3:
.word 2,3,4,7,8,9,13,17,18,19,22,23,24

@cut pattern
level_image_4:
.word 1,2,5,6,7,9,13,16,17,19,21,22,0
@home pattern
level_image_5:
.word 3,7,8,9,11,12,13,14,15,17,18,19,22,24