# COMP2300 Assignment 2 Template 

This is the template repository for COMP2300 assignment 2.

You should look at the assignment instructions online: https://comp.anu.edu.au/courses/comp2300/assessments/digital-pet/

In this digital pet design, I made a small toy that guesses patterns from memory.
I use the length of time to classify the grades.


#小玩具功能说明：
##Input:
	Button A：你每次移动到你想画的那个点上可以通过A键来确认。确认的时候有确认声音。
	Button B: 你可以通过B键来实现每个红点的移动，从而达到移动的目的。
	Touch LOGO：通过触屏的操作你可以做到两点。

###First
	你画完了pattern之后触屏玩具会给你反馈。如果你画对了那给你笑脸的同时，播放画对对应的声音。画错了给你哭脸，同时播放画错时的声音。
###Second
	你画对了之后进入到下一个level这个时候，你是看不到这个level的pattern。这个时候触屏你会看到这个level的pattern。但是这时候因为你相当于什么都没输入，所以玩具认为你画错了，所以会给你哭脸和画错声。

Output：
5*5 LED matrix: 通过5*5 LED 小玩具给你显示各level图案以及你每次移动到的红点位置。而且也通过这个给你反馈你画的对不对。
Speaker：通过speaker你听到各种状态的声音。

等级一共有6级。
The patterns corresponding to each level are as follows:
level0: small square
level1: all-seeing eye
level2: cup
level3: hourglass
level4: scissors
level5: home

你必须画对目前的level pattern 才能进入下一个level。
一个level中如果画错了那么你必须重头开始画那个level的pattern。
画pattern的顺序也很重要：必须从左到右，从上到下的顺序来一点一点画出level pattern。
通过所有的level 画完了6个pattern之后你会看到“WIN”而且听到恭喜你的声音。这个声音跟一开始开启玩具的时候的启动声音一模一样。


程序实现细节：
这次设计中我用了如下表的芯片上的资源。
资源名称	资源用处	备注
Systick Timer		
		
		

	Lib 文件夹结构：

除了老师提供的 audio.s ,led.s,symbol.s,util.s 之外我另外编写了3个s文件。
分别是：
Button.s  ,timer.s  and  user_function.s
每个s文件里面写的function和他们的功能如下。
Button.s:
init_buttons：
Input parameter：NO
功能：初始化你用到的两个button和一个触摸屏 LOGO对应的三个GPIO引脚。
三个引脚的中断触发方式是检测到falling edge的时候会触发GPIOTE 中断。
Button A: P0.14  
Button B:P0.23
Touch LOGH:P1.04

timer.s:
init_timer：
Input parameter：NO
功能：初始化两个定时器Timer 0 and Timer 1
Timer 0：频率设置为1MHz。用到了Capture/Compare register 0。
TimerCC0 Value:2000
BITMODE：32 bit timer bit width
每过2ms 会发生一次中断。
Timer 1：频率设置为1MHz。用到了Capture/Compare register 0。
TimerCC0 Value:10000
BITMODE：32 bit timer bit width
所以每过10ms 会发生一次中断。




User_function.s:
Show_right_image：用来画笑脸。
Show_error_image：用来画哭脸。
Show_level_imag_0：用来画level 0 pattern.
Show_level_imag_1：用来画level 1 pattern.
Show_level_imag_2：用来画level 2 pattern.
Show_level_imag_3：用来画level 3 pattern.
Show_level_imag_4：用来画level 4 pattern.
Show_level_imag_5：用来画level 5 pattern.
Show_level_imag_6：用来画 ”W” pattern.
Show_level_imag_7：用来画 ”I” pattern.
Show_level_imag_8：用来画 ”N” pattern.

sound_check : 播放按下A键时的声音
start_sound  : 播放启动玩具时的声音
right_sound  : 播放画对时的声音
wrong_sound : 播放画错时的声音

TIMER0_IRQHandler ：TIMER0 中断处理函数
在这里先清理中断标记
同时设置了 表示Timer0 中断发生的flag全局变量。
SysTick_Handler ：   Systick 中断处理函数在这里millisec_counter变量加一。


	主函数结构
Main.s:
First :初始化所有必要的外设以及Systick
Second ：进入主循环一直检查三个input的flag。
 
分别有三个input事件对应的处理单元。

touch_pressed:
Touch LOGG被触屏时运行到这个单元。
功能是：
First: 检查你的目前level
Second: 通过Case(n) (n=0~5)调用把目前level对应的pattern画的函数 。
       然后检查你输入的pattern跟目前levelpattern比较。
      画对了去到input_right 单元执行画对的时候的操作。
      画错了去到input_error 单元执行画错时的操作。
Congratulation 单元是执行 ：“WIN”和 恭喜声音的函数调用。


button_A_pressed:
A 键按下的时候运行到这个单元。
功能是：
First: 调用 sound_check
Second: 把目前红点的位置保存到your_input_position数组里面。


button_B_pressed:
B 键按下的时候运行到这个单元。
功能是：
把红点移动到next position。




附录
1.	Timer0 中断的功能	
Timer0 中断来记录短时间，从而达到短时间内刷屏幕这样实现了画出pattern的目的。

2.	Timer 1 中断的功能
除了Timer 0 另外加入这个定时器的原因是我们的两个按键按下的时候出现抖动现象。
为了防止这个抖动设计了软件消除抖动的功能。
原理是按键采用中断驱动方式，当按键按下以后触发按键中断，在按键中断中开启一个定时器，定时周期为 10ms，当定时时间到了以后就会触发定时器中断，最后在定时器中断处理函数中读取按键的值，如果按键值还是按下状态那就表示这是一次有效的按键。













