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

# 更改默认密码
sed -i 's/root::0:0:99999:7:::/root:$1$MhPcOOTE$DOOyDUwKjP9xnoSfaczsk.:19058:0:99999:7:::/g' package/base-files/files/etc/shadow

# 修改默认IP
sed -i 's/192.168.1.1/192.168.88.8/g' package/base-files/files/bin/config_generate

# 修改hostname
sed -i 's/OpenWrt/XinV-2.0/g' package/base-files/files/bin/config_generate

# Modify the version number版本号里显示一个自己的名字（AutoBuild $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt /Build $(TZ=UTC-8 date "+%Y.%m.%d") @ XinV-2.0 /g' package/lean/default-settings/files/zzz-default-settings

# 修改主机名字，把XinV-2.0修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='XinV-2.0'' package/lean/default-settings/files/zzz-default-settings

# Clone community packages to package/community
#mkdir package/community
#pushd package/community

# Add Kenzok8's Packages & Dependency
#mkdir temp_packages
#git clone https://github.com/kenzok8/small.git temp_packages/ && mv temp_packages/* package/ && rm -rf temp_packages && mkdir temp_packages
#git clone https://github.com/kenzok8/openwrt-packages.git temp_packages/ && mv temp_packages/* package/ && rm -rf temp_packages
#git clone https://github.com/kenzok8/small.git
#git clone https://github.com/kenzok8/openwrt-packages.git
#git clone --no-checkout https://github.com/kenzok8/small.git tmp/package/ && mv tmp/.git . && rmdir tmp && git reset --hard HEAD
#git clone --no-checkout https://github.com/kenzok8/openwrt-packages.git tmp/package/ && mv tmp/.git . && rmdir tmp && git reset --hard HEAD
#popd

# Add Coolsnowwolf's Packages
#git clone https://github.com/coolsnowwolf/lede.git

# Add Garypang13's Packages
#git clone https://github.com/garypang13/openwrt-packages.git

# Add other packages
#git clone https://github.com/rufengsuixing/luci-app-onliner.git # Add luci-app-onliner
#git clone https://github.com/tindy2013/openwrt-subconverter.git # Add subconverter
#git clone https://github.com/zcy85611/Openwrt-Package.git # Add luci-udptools
#git clone https://github.com/destan19/OpenAppFilter.git # Add OpenAppFilter
#git clone https://github.com/Zxilly/UA2F.git package/lean/UA2F
git clone https://github.com/aswifi/UA2F.git package/lean/UA2F
git clone https://github.com/CHN-beta/rkp-ipid.git package/lean/rkp-ipid
git clone https://github.com/sirpdboy/NetSpeedTest.git package/lean/NetSpeedTest
git clone https://github.com/esirplayground/luci-app-poweroff.git package/lean/luci-app-poweroff
git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/lean/luci-app-autotimeset
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/lean/luci-theme-opentopd

# Add luci-theme-argon
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
#rm -rf ../lean/luci-theme-argon

# Add luci-theme-argon-18.06_sed
#sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile

# 取消bootstrap为默认主题 & Add luci-theme-atmaterial_new
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 替换默认主题为 luci-theme-darkmatter
# sed -i 's/更改前的信息/更改后的信息/g' ./要修改的文件的目录（可以用本地查看）
sed -i 's/luci-theme-bootstrap/luci-theme-darkmatter/g' feeds/luci/collections/luci/Makefile
