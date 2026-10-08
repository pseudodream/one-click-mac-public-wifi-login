#!/bin/zsh
# 一键安装：在桌面生成「弹出WiFi验证.app」
# 用法：zsh install.sh
set -e

APP_PATH="$HOME/Desktop/弹出WiFi验证.app"
SCRIPT_PATH="$(mktemp -t captive_portal).applescript"

cleanup() { rm -f "$SCRIPT_PATH"; }
trap cleanup EXIT

# 原理：用探测地址触发强制门户。
# 处于门户网络时，该请求会被网络劫持并重定向到登录页，浏览器随即打开登录页面。
# 不依赖 macOS 的 captive portal 助手 UI —— 该 UI 在 macOS 26 (Tahoe) 已被 Apple 移除。
cat > "$SCRIPT_PATH" <<'APPLESCRIPT'
on run
	set probeURL to "http://captive.apple.com/hotspot-detect.html"
	set wifiDev to do shell script "networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}'"
	set ssid to do shell script "networksetup -getairportnetwork " & quoted form of wifiDev & " 2>/dev/null"
	if ssid starts with "You are not associated" then
		display alert "未连接到 WiFi" message "请先连接图书馆等场所的 WiFi，再运行本工具。" as warning
		return
	end if
	set res to do shell script "curl -s -o /dev/null -w '%{http_code} %{redirect_url}' --max-time 8 " & quoted form of probeURL
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to " "
	set parts to text items of res
	set AppleScript's text item delimiters to oldDelims
	set code to item 1 of parts
	if code is "301" or code is "302" or code is "307" then
		do shell script "open " & quoted form of (item 2 of parts)
	else
		do shell script "open " & quoted form of "http://captive.apple.com"
	end if
end run
APPLESCRIPT

echo "==> 正在为你在桌面创建「弹出WiFi验证」应用..."
rm -rf "$APP_PATH"
osacompile -o "$APP_PATH" "$SCRIPT_PATH" 2>/dev/null

echo ""
echo "✅ 完成！应用已放到桌面：$APP_PATH"
echo ""
echo "使用方法："
echo "  1. 连接需要网页验证的 WiFi（图书馆/机场/酒店等）"
echo "  2. 如果登录页没有自动弹出，双击桌面上的「弹出WiFi验证」"
echo "  3. 浏览器会自动打开 WiFi 验证页面"
echo ""
echo "提示：也可以把该应用拖到程序坞（Dock）方便点击。"