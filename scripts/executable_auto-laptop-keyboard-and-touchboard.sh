#!/bin/bash
xinput list | grep 'USB Keyboard' > /dev/null
if [ $? -eq 0 ]; then   # has 'USB Keyboard'
    ~/scrips/disable-laptop-keyboard.sh
    ~/scrips/disable-touchpad.sh
    echo "Laptop keyborad and touchpad has been disabled!"
else
    ~/scrips/enable-laptop-keyboard.sh
    ~/scrips/enable-touchpad.sh
    echo "Laptop keyborad and touchpad has been enabled!"
fi
