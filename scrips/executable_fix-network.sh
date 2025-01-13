#!/bin/bash
# Fix network connect after resuming from hibernate
MOD="r8169"
rmmod "$MOD"
modprobe "$MOD"
