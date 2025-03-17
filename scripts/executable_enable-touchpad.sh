#!/bin/bash
xinput enable `xinput list | grep 'Touchpad' | grep -E -o "id=[0-9]*" | grep -E -o "[0-9]*"`

