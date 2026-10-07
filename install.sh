#!/bin/zsh
# 一键安装：在桌面生成「弹出WiFi验证.app」
# 用法：zsh install.sh
set -e

APP_PATH="$HOME/Desktop/弹出WiFi验证.app"

# macOS 新旧版本中强制门户助手的名字不同：
#   旧版: /System/Library/CoreServices/CaptiveNetworkSupport.app
#   新版 (macOS Tahoe 及之后): /System/Library/CoreServices/Captive Network Assistant.app
ASSISTANT=""
for candidate in \
  "/System/Library/CoreServices/Captive Network Assistant.app" \
  "/System/Library/CoreServices/CaptiveNetworkSupport.app"; do
  if [ -d "$candidate" ]; then
    ASSISTANT="$candidate"
    break
  fi
done

if [ -z "$ASSISTANT" ]; then
  echo "❌ 未找到系统自带的强制门户助手（Captive Network Assistant）。"
  echo "   你的 macOS 版本可能较特殊，欢迎到仓库提 issue 反馈。"
  exit 1
fi

echo "==> 找到系统组件: $ASSISTANT"
echo "==> 正在为你在桌面创建「弹出WiFi验证」应用..."

rm -rf "$APP_PATH"
osacompile -o "$APP_PATH" -e "do shell script \"open '$ASSISTANT'\""

echo ""
echo "✅ 完成！应用已放到桌面：$APP_PATH"
echo ""
echo "使用方法："
echo "  1. 连接需要网页验证的 WiFi（图书馆/机场/酒店等）"
echo "  2. 如果登录页没有自动弹出，双击桌面上的「弹出WiFi验证」即可"
echo ""
echo "提示：也可以把该应用拖到程序坞（Dock）方便点击。"
