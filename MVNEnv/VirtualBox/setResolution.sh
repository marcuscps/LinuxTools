#!/bin/bash

xrandr --addmode VGA-1 1920x1080
xrandr --auto --output VGA-0 --mode 1920x1080 --right-of VGA-1 --output VGA-1 --mode 1920x1080

