#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.5.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 移除重复软件包
rm -rf package/lean/luci-app-netdata
rm -rf package/lean/luci-app-wrtbwmon
rm -rf package/lean/luci-theme-argon

# 添加额外软件包，不在根目录要用svn co，然后tree/main替换成trunk
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced package/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest package/luci-app-netspeedtest
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-arpbind package/luci-app-arpbind
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-autoreboot package/luci-app-autoreboot
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ipsec-vpnd package/luci-app-ipsec-vpnd
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ramfree package/luci-app-ramfree
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-softethervpn package/luci-app-softethervpn
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore package/autocore
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/automount package/automount
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipv6-helper package/ipv6-helper
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-zerotier package/luci-app-zerotier

#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autosamba package/autosamba
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd package/luci-app-vlmcsd
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc package/luci-app-turboacc
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/shortcut-fe

# 流量监控
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon

# Themes
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 修改插件名字
sed -i 's/"流量"/"实时流量监测"/g' `grep "流量" -rl ./`

./scripts/feeds update -a
./scripts/feeds install -a
