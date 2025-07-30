<h1>kali HID watch-dw99</h1>
本项目为开源项目，为你的dw99实现kali hid攻击！成为渗透利器（仅适配dw99）
通过解包内核发现，配置中仅缺失CONFIG_USB_CONFIGFS_HID=y相关内核开关
通过此发现而得到了此magisk模块，可以通过conighs创建用户hid节点，而不修改内核，通过实现动态注入HID
由于各系统内核不同，无脑刷可能会导致无效，甚至引发avb校验
由于此模块是在 Bl锁已解锁的状态下测试，未通过其他系统测试，如未解bl锁，请谨慎刷入
REM 打开命令提示符(cmd)的Rubber Ducky脚本
DELAY 1000         // 初始延迟确保系统就绪
GUI r              // 按下Win+R打开运行窗口
DELAY 300          // 等待运行窗口弹出
STRING cmd         // 输入"cmd"
ENTER              // 执行命令
![](https://github.com/key888qw/DW99-kali-HID/blob/main/images/Screenshot_20250729-120223.png)
解包boot发现仅无CONFIG_USB_CONFIGFS_HID=y
![](https://github.com/key888qw/DW99-kali-HID/blob/main/images/kali.png)
