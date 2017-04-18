# Hybris-6-
# 安装步骤：
## 1.解压Hybir压缩包，安装Git.exe

## 2.将HYBRIS自动安装脚本放入根目录，与hybris、installer同级

## 3.如果是普通安装执行3.1步骤，如果是安装git上已有的项目，执行3.2步骤

###    3.1 直接运行init.bat

###    3.2 请先修改 ...\HYBRIS自动安装脚本\b2b_b2c_china下gradle.properties的一些特有属性
（比如：关于jrebel的配置路径 只用将`tomcat_javaoptions="需要修改的内容"`修改为`tomcat_javaoptions=“修改后的内容”`）
       然后运行install.bat

## 4.弹出窗口时输入git用户名和密码。

## 5.等待安装完成，安装完成后会启动hybris服务。

附：
## 1.仅供hybris初次安装使用，下次启动hybris服务请用bin/platform/hybrisserver.bat

## 2.此脚本仅限于b2c_china的安装

## 3.若git地址修改，请更改install.bat

## 4.详细内容参见build.gradle注释或bat echo

## 5.Mac、Linux用户请自行参照脚本运行相应命令  1
