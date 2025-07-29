#!/system/bin/sh

# 等待系统稳定
sleep 10

ui_print "- Starting HID injection service"

# 1. 创建 HID 功能
mkdir -p /config/usb_gadget/g1/functions/hid.usb0

# 2. 设置 HID 参数
echo 1 > /config/usb_gadget/g1/functions/hid.usb0/protocol
echo 8 > /config/usb_gadget/g1/functions/hid.usb0/report_length

# 3. 加载 HID 报告描述符 (键盘)
echo -ne "\x05\x01\x09\x06\xa1\x01\x05\x07\x19\xe0\x29\xe7\x15\x00\x25\x01\x75\x01\x95\x08\x81\x02\x95\x01\x75\x08\x81\x03\x95\x05\x75\x01\x05\x08\x19\x01\x29\x05\x91\x02\x95\x01\x75\x03\x91\x03\x95\x06\x75\x08\x15\x00\x25\x65\x05\x07\x19\x00\x29\x65\x81\x00\xc0" > /config/usb_gadget/g1/functions/hid.usb0/report_desc

# 4. 关联功能到 b.1 配置
ui_print "- Linking HID to b.1 config"
ln -s /config/usb_gadget/g1/functions/hid.usb0 /config/usb_gadget/g1/configs/b.1

# 5. 绑定到 USB 控制器
UDC=$(ls /sys/class/udc | head -n1)
ui_print "- Binding to UDC: $UDC"
echo $UDC > /config/usb_gadget/g1/UDC

# 6. 创建设备节点并设置权限
ui_print "- Creating HID device node"
mknod /dev/hidg0 c $(cat /sys/class/udc/$UDC/device/misc/hidg0/dev | tr : ' ') 0
chmod 666 /dev/hidg0

ui_print "- HID 设置好了！completed successfully"