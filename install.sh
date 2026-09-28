#!/bin/zsh
# 一键安装：在桌面生成「弹出WiFi验证.app」
# 用法：zsh install.sh
set -e

APP_PATH="$HOME/Desktop/弹出WiFi验证.app"
ASSISTANT="/System/Library/CoreServices/CaptiveNetworkSupport.app"

echo "==> 正在为你在桌面创建「弹出WiFi验证」应用..."

osacompile -o "$APP_PATH" -e "do shell script \"open $ASSISTANT\""

echo "✅ 完成！应用已放到桌面：$APP_PATH"
echo ""
echo "使用方法："
echo "  1. 连接需要网页验证的 WiFi（图书馆/机场/酒店等）"
echo "  2. 如果登录页没有自动弹出，双击桌面上的「弹出WiFi验证」即可"
echo ""
echo "提示：也可以把该应用拖到程序坞（Dock）方便点击。"
