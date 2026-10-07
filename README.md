# 一键弹出 Mac 公共 WiFi 验证页

> 解决连接图书馆、机场、酒店等公共 WiFi 时，登录验证弹窗不出现的问题。

在图书馆、机场、酒店等场所连接需要**网页验证的 WiFi** 时，macOS 有时不会自动弹出登录页，
很多人只能去「系统设置 → 网络 → 位置」里切换位置来"骗"系统重新检测。

这个小工具让你**一键弹出 WiFi 验证窗口**，不用再切换位置。

## 原理

macOS 自带一个「强制门户助手」（Captive Network Assistant），本该在连接到需要验证的
WiFi 时自动弹出登录窗口。但系统有时会误判"这个网络已经有网"，导致验证页弹不出来。

本工具就是手动启动这个助手，登录窗口会立即弹出。该组件在新旧 macOS 版本中名字不同
（新版为 `Captive Network Assistant.app`，旧版为 `CaptiveNetworkSupport.app`），
安装脚本会自动检测你系统上的正确路径。

## 安装（10 秒）

打开「终端」（Terminal），粘贴运行：

```bash
zsh <(curl -fsSL https://raw.githubusercontent.com/pseudodream/one-click-mac-public-wifi-login/main/install.sh)
```

或者手动下载 `install.sh` 后运行：

```bash
zsh install.sh
```

> 国内网络如果访问 raw.githubusercontent.com 缓慢或超时，可改用加速镜像：
>
> ```bash
> zsh <(curl -fsSL https://ghfast.top/https://raw.githubusercontent.com/pseudodream/one-click-mac-public-wifi-login/main/install.sh)
> ```
>
> 安装脚本不下载任何文件，全程本地离线操作，可放心运行。

安装完成后，桌面会出现 **「弹出WiFi验证」** 应用。

## 使用

1. 连接需要网页验证的 WiFi（图书馆 / 机场 / 酒店 / 咖啡店……通用）
2. 如果登录页没有自动弹出，**双击桌面的「弹出WiFi验证」**
3. 登录即可

也可以把应用拖到程序坞（Dock），点一下就弹。

## 备用方法（不安装任何东西）

在 Safari / Chrome 地址栏输入（注意必须是 `http` 开头）：

```
http://captive.apple.com
```

浏览器会被重定向到 WiFi 验证页，效果相同。

## 兼容性

- ✅ 新旧 macOS 版本均支持（脚本自动适配新旧两种组件路径，已在新版 macOS Tahoe 上验证）
- ✅ 适用于一切需要网页认证的 WiFi，不限于图书馆
- ❌ 不适用于需要客户端软件（如锐捷、Dr.COM）认证的校园网

## License

MIT
