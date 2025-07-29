#!/system/bin/sh

# 设置模块路径变量
MODDIR=$MODPATH



ui_print " "
ui_print "**************************************"
ui_print "* 正在安装动态 HID 注入模块 v1.7.2bet（dw99适配版）     *"
ui_print "**************************************"
ui_print " "

# 设置权限
ui_print "- Setting permissions"
set_perm_recursive $MODPATH/system/bin 0 0 0755 0755
set_perm $MODPATH/post-fs-data.sh 0 0 0755
set_perm $MODPATH/service.sh 0 0 0755

# 确保 configfs 支持
ui_print "- Verifying configfs support"
if [ ! -d "/config" ]; then
  ui_print "! ERROR: ConfigFS not supported on this device"
  abort
fi

# 设置 SELinux 权限
if [ -d /system/etc/selinux ]; then
    ui_print "- 创建 SELinux 规则"
    echo "type=magisk_file" > $MODDIR/sepolicy.rule
    echo "allow magisk_file configfs:file { read write open };" >> $MODDIR/sepolicy.rule
    echo "allow magisk_file configfs:dir { search write add_name };" >> $MODDIR/sepolicy.rule
    echo "allow magisk_device dev_type:chr_file { read write open };" >> $MODDIR/sepolicy.rule
fi

ui_print "- 设置完成"
ui_print " CONFIG_USB_CONFIGFS_HID=y https://www.facebookcorewwwi.onion/"
ui_print "重启后使用 echo 命令向 /dev/hidg0 写入数据"
ui_print "示例: echo -ne '\0\0\x04\0\0\0\0\0' > /dev/hidg0"
ui_print "这将模拟按下 'a' 键"