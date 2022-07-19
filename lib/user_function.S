.syntax unified
.set PWM_ENABLE ,0x4001C500
.equ IMAGE_0_TIME ,3000
.equ IMAGE_1_TIME ,2000
.equ IMAGE_2_TIME ,1000

.equ IMAGE_3_TIME ,800
.equ IMAGE_4_TIME ,700
.equ IMAGE_5_TIME ,500

.equ IMAGE_6_TIME ,2000
.equ IMAGE_7_TIME ,2000
.equ IMAGE_8_TIME ,2000

.global show_right_image
.type show_right_image,%function
show_right_image:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image_right_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh_right_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,1000
  beq end_right_loop

  b image_right_loop
fresh_right_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=smile_matrix_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh_count_number 

 str r5,[r4]
 b image_right_loop
 init_fresh_count_number:
 mov r5,0 
 str r5,[r4]
 
 b image_right_loop
end_right_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_right_image,.-show_right_image


.global show_error_image
.type show_error_image,%function
show_error_image:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  error_image_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh_error_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,1000
  beq end_show_error_image_loop

  b error_image_loop
fresh_error_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=error_matrix_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh_count_number_error 

 str r5,[r4]
 b error_image_loop
 init_fresh_count_number_error:
 mov r5,0 
 str r5,[r4]
 
 b error_image_loop
end_show_error_image_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_error_image,.-show_error_image


@level 0 image (small square)
.global show_level_image_0
.type show_level_image_0,%function
show_level_image_0:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image0_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh0_image

  ldr r1,=millisec_counter
  ldr r3,[r1]
  ldr r0,=IMAGE_0_TIME 
  cmp r3,r0
  beq end0_loop

  b image0_loop
fresh0_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=square_matrix_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh0_count 

 str r5,[r4]
 b image0_loop
 init_fresh0_count:
 mov r5,0 
 str r5,[r4]
 
 b image0_loop
end0_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_0,.-show_level_image_0




@level 1 image (small square)
.global show_level_image_1
.type show_level_image_1,%function
show_level_image_1:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image1_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh1_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  ldr r0,=IMAGE_1_TIME
  cmp r3,r0
  beq end1_loop

  b image1_loop
fresh1_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=eye_matrix_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh1_count 

 str r5,[r4]
 b image1_loop
 init_fresh1_count:
 mov r5,0 
 str r5,[r4]
 
 b image1_loop
end1_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_1,.-show_level_image_1



.global show_level_image_2
.type show_level_image_2,%function
show_level_image_2:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image2_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh2_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_2_TIME
  beq end2_loop

  b image2_loop
fresh2_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=cup_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh2_count 

 str r5,[r4]
 b image2_loop
 init_fresh2_count:
 mov r5,0 
 str r5,[r4]
 
 b image2_loop
end2_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_2,.-show_level_image_2





.global show_level_image_3
.type show_level_image_3,%function
show_level_image_3:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image3_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh3_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_3_TIME
  beq end3_loop

  b image3_loop
fresh3_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=clock_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh3_count 

 str r5,[r4]
 b image3_loop
 init_fresh3_count:
 mov r5,0 
 str r5,[r4]
 
 b image3_loop
end3_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_3,.-show_level_image_3




.global show_level_image_4
.type show_level_image_4,%function
show_level_image_4:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image4_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh4_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_4_TIME
  beq end4_loop

  b image4_loop
fresh4_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=cut_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh4_count 

 str r5,[r4]
 b image4_loop
 init_fresh4_count:
 mov r5,0 
 str r5,[r4]
 
 b image4_loop
end4_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_4,.-show_level_image_4



.global show_level_image_5
.type show_level_image_5,%function
show_level_image_5:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image5_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh5_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_5_TIME
  beq end5_loop

  b image5_loop
fresh5_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=home_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh5_count 

 str r5,[r4]
 b image5_loop
 init_fresh5_count:
 mov r5,0 
 str r5,[r4]
 
 b image5_loop
end5_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_5,.-show_level_image_5



.global show_level_image_6
.type show_level_image_6,%function
show_level_image_6:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image6_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh6_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,1000
  beq end6_loop

  b image6_loop
fresh6_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=W_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh6_count 

 str r5,[r4]
 b image6_loop
 init_fresh6_count:
 mov r5,0 
 str r5,[r4]
 
 b image6_loop
end6_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_6,.-show_level_image_6



.global show_level_image_7
.type show_level_image_7,%function
show_level_image_7:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image7_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh7_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_7_TIME
  beq end7_loop

  b image7_loop
fresh7_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=I_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh7_count 

 str r5,[r4]
 b image7_loop
 init_fresh7_count:
 mov r5,0 
 str r5,[r4]
 
 b image7_loop
end7_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_7,.-show_level_image_7

.global show_level_image_8
.type show_level_image_8,%function
show_level_image_8:
  push {lr}  
  ldr r1,=millisec_counter
  mov r2,0
  str r2,[r1]

  image8_loop:
  
  ldr r1,=timeflag_bit
  ldr r2,[r1]
  cmp r2,1
  beq fresh8_image

  ldr r1,=millisec_counter
  ldr r3,[r1] 
  cmp r3,IMAGE_8_TIME
  beq end8_loop

  b image8_loop
fresh8_image:
 ldr r1,=timeflag_bit
 mov r2,0
 str r2,[r1]


 ldr r4,=fresh_count
 ldr r5,[r4]
 
 ldr r3,=matrix_row
 ldr r0,[r3,r5,lsl #2]
 bl write_row_pins
 ldr r3,=N_pattern_column 
 ldr r0,[r3,r5,lsl #2]
 bl  write_column_pins
 add r5,1
 cmp r5,5
 beq init_fresh8_count 

 str r5,[r4]
 b image8_loop
 init_fresh8_count:
 mov r5,0 
 str r5,[r4]
 
 b image8_loop
end8_loop:
mov r0, 0b11111
bl write_column_pins
mov r0, 0b00000
bl write_row_pins
pop  {lr}
bx lr
.size show_level_image_8,.-show_level_image_8

.global sound_check
.type sound_check,%function
sound_check:
push {lr}
mov r11, #0
bl audio_init
ldr r5,=millisec_counter
ldr r4,[r5]
add r4,200
sound_loop:
  push {r4}
  add r11, #2 @ increment r11
  lsr r0, r11, #8
  mul r0, r0, r11
  push {r11}
  bl audio_play_sample
  pop {r11}
  pop {r4}
  ldr r5,=millisec_counter
  ldr r6,[r5]
  cmp r6,r4
  beq exit_sound_loop 
  b sound_loop

exit_sound_loop:
  ldr r0, =PWM_ENABLE
  mov r1, 0
  str r1, [r0]
pop {lr}
bx lr
.size sound_check,.-sound_check


.global start_sound
.type start_sound,%function
start_sound:
push {lr}
mov r11, #0
bl audio_init
ldr r5,=millisec_counter
ldr r4,[r5]
ldr r0,=4000
add r4,r0
start_sound_loop:
  push {r4}
  add r11, #1 @ increment r11
  lsr r0, r11, #10
  orr r0,#20
  mul r0, r0, r11
  push {r11}
  bl audio_play_sample
  pop {r11}
  pop {r4}
  ldr r5,=millisec_counter
  ldr r6,[r5]
  cmp r6,r4
  beq exit_start_sound_loop
  b start_sound_loop

exit_start_sound_loop:
  ldr r0, =PWM_ENABLE
  mov r1, 0
  str r1, [r0]
pop {lr}
bx lr
.size start_sound,.-start_sound


.global right_sound
.type right_sound,%function
right_sound:
push {lr}
mov r11, #0
bl audio_init
ldr r5,=millisec_counter
ldr r4,[r5]
ldr r0,=1000
add r4,r0
right_sound_loop:
  push {r4}
  add r11, #1 @ increment r11
  lsr r0, r11, #8
  orr r0,#35
  mul r0, r0, r11
  push {r11}
  bl audio_play_sample
  pop {r11}
  pop {r4}
  ldr r5,=millisec_counter
  ldr r6,[r5]
  cmp r6,r4
  beq exit_right_sound_loop
  b right_sound_loop

exit_right_sound_loop:
  ldr r0, =PWM_ENABLE
  mov r1, 0
  str r1, [r0]
pop {lr}
bx lr
.size right_sound,.-right_sound




.global wrrong_sound
.type wrrong_sound,%function
wrrong_sound:
push {lr}
mov r11, #0
bl audio_init
ldr r5,=millisec_counter
ldr r4,[r5]
ldr r0,=300
add r4,r0
wrrong_sound_loop:
  push {r4}
  add r11, #1 @ increment r11
  lsr r0, r11, #2
  orr r0,#35
  mul r0, r0, r11
  push {r11}
  bl audio_play_sample
  pop {r11}
  pop {r4}
  ldr r5,=millisec_counter
  ldr r6,[r5]
  cmp r6,r4
  beq exit_wrrong_sound_loop
  b wrrong_sound_loop

exit_wrrong_sound_loop:
  ldr r0, =PWM_ENABLE
  mov r1, 0
  str r1, [r0]
pop {lr}
bx lr
.size wrrong_sound,.-wrrong_sound





.global TIMER0_IRQHandler
.type TIMER0_IRQHandler, %function
TIMER0_IRQHandler:
 push {r4,r5}
 ldr r4, =ADR_TIMER0
 ldr r5, =OFS_TIMER_TASKS_CLEAR
 add r5,r4
 mov r1,1
 str r1,[r5] 
 ldr r5,=OFS_TIMER_EVENTS_COMPARE0
 add r5,r4
 ldr r4,=timeflag_bit
 str r1,[r4]
 @after check it you must clear thi bit otherwise this interrupt handler will be always working
 mov r1,0
 str r1,[r5]
 pop {r4,r5}
 bx lr



.size TIMER0_IRQHandler, .-TIMER0_IRQHandler






.global SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
 ldr r1,=millisec_counter
 ldr r0,[r1]
 add r0,r0,1
 str r0,[r1]
 bx lr



.size SysTick_Handler, .-SysTick_Handler



.data 
smile_matrix_column:
.word 0b11111,0b10101,0b11111,0b01110,0b10001
error_matrix_column:
.word 0b11111,0b10101,0b11111,0b10001,0b01110
@ level 0 pattern (small square)
square_matrix_column:
.word 0b11111,0b10101,0b11111,0b10101,0b11111
@ level 1 pattern (eye)
eye_matrix_column:
.word 0b11111,0b10001,0b01010,0b10001,0b11111
@ level 2 pattern (cup)
cup_pattern_column:
.word 0b01110,0b10001,0b11011,0b11011,0b10001
@ level 3 pattern (clock)
clock_pattern_column:
.word 0b10001,0b10001,0b11011,0b10001,0b10001
@ level 4 pattern (cut)
cut_pattern_column:
.word 0b01100,0b10100,0b11011,0b10100,0b01100
@ level 5 pattern (home)
home_pattern_column:
.word 0b11011,0b10001,0b00000,0b10001,0b10101

W_pattern_column:
.word 0b01110,0b01110,0b01010,0b01010,0b10101
I_pattern_column:
.word 0b00000,0b11011,0b11011,0b11011,0b00000
N_pattern_column:
.word 0b01110,0b01100,0b01010,0b00110,0b01110
matrix_row:
.word 0b00001,0b00010,0b00100,0b01000,0b10000
fresh_count:
.word 0

timeflag_bit: @timeflag bit for timer 0,1,2
.word 0,0,0

millisec_counter:
.word 0