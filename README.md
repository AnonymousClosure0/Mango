
# Usage
```shell
git clone --recursive https://github.com/AnonymousClosure0/Mango.git
cd Mango
# go version go1.22.1 darwin/arm64
# Xcode 15.0.1
# iOS 16
# cmake version 3.27.1 | GNU Make 3.81
# before run, please install 'go' and 'make' tools
# gen Xray-Core Framework and hev-socks5-tunnel libray
sh build_env.sh
# open ios project
```

系统要求：iOS16.0+

开发语言：Swift、Golang、C、Assembly

界面框架：SwiftUI、UIKit

内核：
    xray: https://github.com/XTLS/Xray-core(1.8.0)

Tun2Socks
    https://github.com/heiher/hev-socks5-tunnel
    
编译：
    1.下载工程
    2.更新依赖
    3.修改Config.xcconfig中DEVELOPMENT_TEAM & APP_ID
  
关联项目：
    XrayKit：https://github.com/daemooon/XrayKit
    Tun2SocksKit：https://github.com/daemooon/Tun2SocksKit
