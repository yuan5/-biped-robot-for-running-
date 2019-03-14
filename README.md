# biped robot for running
# 介绍（introduce）
设计制作一款能够奔跑的双足机器人，只为稳定奔跑。省去一切华丽的表演动作。如果一定要给它取个名字，就叫狂奔吧！Design and make a biped robot that can run, only for stable running. Eliminate all gorgeous performances. If you must give it a name, it is called crazy runner.
# 前言（proface）
  大学生活即将结束，感慨壮志未酬，我移植想要设计制作双足机器人并未能完全完成，因此希望通过将其开源，集众网友的力量大家共同完成我尚未完成的项目。首先说明为什么不用纯英文编写，最重要的原因是在下英语不行。其次，我辈皆为华夏子孙，自然以母语为第一语言，同时国内仍旧有许多优秀的研究人员的英文水平并不是很好，看英文比较费力，服务绝大多数人罢。其次，我会将所有的代码都公布，供大家调试使用，代码包含C代码、C++编写的上位机工程代码（ubuntu16.04+Qt）、matlab编写的脚本代码，同时会公布一些图纸。切记鄙人不允许他人私自将该项目中的任何资料源码用于商业目的，如果情况特殊请联系本人（I do not allow others to use any source code of this project for commercial purposes. If the situation is special, please contact me.）。（This paragraph is not translated into English）
# 关于项目（about this repository）
![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/robot2.png)

1.机械结构设计（Mechanical structure design）
  
    .电机（motor）：郎宇x4110s KV340II（sunnysky x4110s KV340II）
    .电机调速器（ESC）：3D XRotor Pro 40A & HOBBYWING X-Rotor 20A(使用本杰明电调也是蛮不错的)
    .电池（battery）：4s锂离子电池（4s Lipo）

  .传动设计（Transmission design）
  
      使用四连杆设计传动机构
      
  .零件设计以及图纸（Parts and drawings）
  
   ![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/drawing.png)
   
2.嵌入式系统设计（Design of Embedded System）
  
  .嵌入式硬件设计（Embedded Hardware Design）
![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/hardware.png) 

      .控制器MCU(controller MCU):  STM32F405
      .角度采集模块MCU（angle module MCU）: STM32F103
      .姿态采集模块MCU（attitude module MCU）: STM32F103
      .角度传感器（angle sensor）：MAXON光电编码器
      .姿态传感器芯片(attitude sensor)： MPU6050

  
  .嵌入式软件设计（Embedded  Design）
  
基于硬件编写实时操作系统，多个MCU芯片协调操作，信号同步使用SPI通信。后期应改为CAN总线通信。基于硬件直接跑的裸机操作系统（裸奔streaking）,设计简单运行效率高。
  
3.编写仿真软件（design simulation software）
  
  ![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/%E6%9C%BA%E5%99%A8%E4%BA%BA%E8%A1%8C%E8%B5%B0.jpg)
