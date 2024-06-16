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
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 删除默认密码 下面这条可以
# sed -i '18s/sed/# sed/g' package/emortal/default-settings/files/99-default-settings
# sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/emortal/default-settings/files/99-default-setting 不起作用

# 移除重复软件包
# rm -rf package/lean/luci-app-netdata 原来的是英文
# rm -rf package/lean/luci-app-wrtbwmon master和21.02分支都不显示
# rm -rf package/lean/luci-theme-argon 所以暂时不知道自带的主题wrtbwmon是否显示正常

# 添加额外软件包，不在根目录要用svn co，然后tree/main替换成trunk
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced package/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest package/luci-app-netspeedtest

# 流量监控（21.02图形界面也无法显示）
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon

# Themes
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 修改插件名字
# sed -i 's/"流量"/"实时流量监测"/g' `grep "流量" -rl ./`

./scripts/feeds update -a
./scripts/feeds install -a
