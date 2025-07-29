#!/system/bin/sh

# 挂载 configfs
ui_print "- Mounting configfs"
mount -t configfs none /config 2>/dev/null

# 创建基础 gadget 结构
ui_print "- Creating USB gadget structure"
mkdir -p /config/usb_gadget/g1
echo 0x1d6b > /config/usb_gadget/g1/idVendor
echo 0x0104 > /config/usb_gadget/g1/idProduct
echo 0x0100 > /config/usb_gadget/g1/bcdDevice
echo 0x0200 > /config/usb_gadget/g1/bcdUSB

# 创建 b.1 配置
ui_print "- Creating b.1 configuration"
mkdir -p /config/usb_gadget/g1/configs/b.1
echo 500 > /config/usb_gadget/g1/configs/b.1/MaxPower