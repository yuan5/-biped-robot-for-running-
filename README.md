# biped robot for running
设计制作一款能够奔跑的双足机器人，只为稳定奔跑。省去一切华丽的表演动作。如果一定要给它取个名字，就叫狂奔吧！Design and make a biped robot that can run, only for stable running. Eliminate all gorgeous performances. If you must give it a name, it is called crazy runner.

  大学生活即将结束，感慨壮志未酬，我移植想要设计制作双足机器人并未能完全完成，因此希望通过将其开源，集众网友的力量大家共同完成我尚未完成的项目。首先说明为什么不用纯英文编写，最重要的原因是在下英语不行。其次，我辈皆为华夏子孙，自然以母语为第一语言，同时国内仍旧有许多优秀的研究人员的英文水平并不是很好，看英文比较费力，服务绝大多数人罢。

![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/robot2.png)

1.机械结构设计（Mechanical structure design）

  .传动设计（Transmission design）
  
      使用四连杆设计传动机构
      
  .零件设计以及图纸（Parts and drawings）
  
   ![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/drawing.png)
   
2.嵌入式系统设计（Design of Embedded System）
  
  .嵌入式硬件设计（Embedded Hardware Design）
![](https://github.com/yuan5/-biped-robot-for-running-/blob/master/image/hardware.png) 

      .控制器MCU:  STM32F405
      .角度采集模块MCU: STM32F103
      .姿态采集模块MCU: STM32F103
      .角度传感器：MAXON光电编码器
      .姿态传感器芯片： MPU6050

  
  .嵌入式软件设计（Embedded  Design）
