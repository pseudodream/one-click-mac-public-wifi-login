# 一键弹出 Mac 公共 WiFi 验证页

> 解决连接图书馆、机场、酒店等公共 WiFi 时，登录验证弹窗不出现的问题。

在图书馆、机场、酒店等场所连接需要**网页验证的 WiFi** 时，macOS 有时不会自动弹出登录页，
很多人只能去「系统设置 → 网络 → 位置」里切换位置来"骗"系统重新检测。

这个小工具让你**一键弹出 WiFi 验证窗口**，不用再切换位置。

## 原理

连接公共 WiFi 后，macOS 会自动访问 `http://captive.apple.com/hotspot-detect.html` 来判断
这个网络是否需要网页验证。**如果需要门户认证，这个请求会被网络拦截并重定向到登录页**。

问题是：新版 macOS（macOS 26 Tahoe 起）常常不自动弹出验证窗口，让人只能去
「系统设置 → 网络 → 位置」里切换位置来"骗"系统重新检测。

本工具做的事很简单：**手动发起这一次探测请求**，并把浏览器直接打开到登录页面。
不依赖 macOS 的验证助手 UI，因此在各版本 macOS 上行为一致。

> 早期版本曾通过启动系统的 `Captive Network Assistant` 弹窗实现，但在 macOS 26 上
> Apple 已移除该组件的界面逻辑（文件仍在，启动无反应），故改为浏览器方案。

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
3. 浏览器会自动打开 WiFi 验证页面，登录即可

也可以把应用拖到程序坞（Dock），点一下就弹。

## 备用方法（不安装任何东西）

在 Safari / Chrome 地址栏输入（注意必须是 `http` 开头）：

```
http://captive.apple.com
```

浏览器会被重定向到 WiFi 验证页，效果相同。

## 兼容性

- ✅ 各版本 macOS 均支持（已在 macOS 26.6.2 Tahoe 上验证）
- ✅ 适用于一切需要网页认证的 WiFi，不限于图书馆
- ❌ 不适用于需要客户端软件（如锐捷、Dr.COM）认证的校园网
- ⚠️ 极少数门户只对特定域名放行、且不劫持 `captive.apple.com` 时，此方法无效；
  此时直接在浏览器输入网关地址（如 `http://192.168.1.1`）即可

## License

MIT
