#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# 移除ACwifidude自带bin目录
rm -rf bin


# 添加 ssr plus
git clone https://github.com/vi-si/openwrt-ssr-plus.git package/openwrt-ssr-plus


# 添加UPX UCL工具包
mkdir -p tools/ucl && wget -P tools/ucl https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile 
mkdir -p tools/upx && wget -P tools/upx https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/upx/Makefile

# 修改makefile
sed  -i '/tools-$(CONFIG_TARGET_orion_generic)/atools-y += ucl upx' tools/Makefile
sed  -i '/dependencies/a\\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
