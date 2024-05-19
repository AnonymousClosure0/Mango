//
//  cxray.c
//  cxray
//
//  Created by Jiang on 2024/3/7.
//

#include <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <os/log.h>
#include <xray/xray.h>
#include "cxray/cxray.h"
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <hev-main.h>

void InternalStartXray(NSString *configDirectory) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        GoString str = { configDirectory.UTF8String, configDirectory.length};
        XrayRun(str);
    });
}

#define CTLIOCGINFO 0xc0644e03UL
struct ctl_info {
    u_int32_t   ctl_id;
    char        ctl_name[96];
};
struct sockaddr_ctl {
    u_char      sc_len;
    u_char      sc_family;
    u_int16_t   ss_sysaddr;
    u_int32_t   sc_id;
    u_int32_t   sc_unit;
    u_int32_t   sc_reserved[5];
};
static int32_t GetTunnelFd(void) {
    struct ctl_info ctlInfo  = {0};
    strcpy((char *)&ctlInfo.ctl_name, "com.apple.net.utun_control");
    for (int fd = 0; fd <= 1024; fd++) {
        struct sockaddr_ctl addr = {0};
        socklen_t len = sizeof(struct sockaddr_ctl);
        int ret = getpeername(fd, (void *)&addr, &len);
        if (ret != 0 || addr.sc_family != AF_SYSTEM) {
            continue;
        }
        if (ctlInfo.ctl_id == 0) {
            ret = ioctl(fd, CTLIOCGINFO, &ctlInfo);
            if (ret != 0) {
                continue;
            }
        }
        if (addr.sc_id == ctlInfo.ctl_id) {
            return fd;
        }
    }
    return -1;
}

void StartTunnel(NSString *config) {
    int fd = GetTunnelFd();
    if (fd < 0) {
        os_log(OS_LOG_DEFAULT, "GetTunnelFd failed!");
        return;
    }
    os_log(OS_LOG_DEFAULT, "GetTunnelFd %{public}d", fd);
    const char *str = config.UTF8String;
    hev_socks5_tunnel_main_from_str((const unsigned char *)str, (uint32_t)config.length, fd);
}

void StopTunnel(void) {
    hev_socks5_tunnel_quit();
}
