#!/bin/bash
xinput disable `xinput list | grep -m 2 'ITE Tech. Inc. ITE Device(8910) Keyboard' | tail -n 1 | grep -E -o "id=[0-9]*" | grep -E -o "[0-9]*"`

