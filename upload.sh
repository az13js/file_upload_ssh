#!/bin/bash

# 本地要同步到远程的文件夹
COPY_DIR="/tmp/www_test"
# 本地打包时使用的临时目录
LOCAL_TMP_DIR="/tmp/$RANDOM-$RANDOM-$RANDOM-$RANDOM-$RANDOM"
# 用来做上传完成标志的文件名，基本名称，需要保证足够唯一
OK_FLAG="4918FCCBE598057E870BB8C15CD39119"
# 上传的机器
MACHINE_PREFIX="user@192.168.0.2"

echo "需要上传的目录：$COPY_DIR"
echo "临时目录（完成后会被自动删除）：$LOCAL_TMP_DIR"
echo "完成标志：$OK_FLAG"

# 检测参数是否正常
if [ ! -d "$COPY_DIR" ];then
    echo "需要上传的目录（$COPY_DIR）不存在，退出脚本。"
    exit
fi

echo "执行：mkdir -p \"$LOCAL_TMP_DIR\""
mkdir -p "$LOCAL_TMP_DIR"

if [ ! -d "$LOCAL_TMP_DIR" ];then
    echo "临时目录（$LOCAL_TMP_DIR）不存在，退出脚本。"
    exit
fi

# 开始执行打包的处理
echo "执行：cp -r \"$COPY_DIR\" \"$LOCAL_TMP_DIR/target\""
cp -r "$COPY_DIR" "$LOCAL_TMP_DIR/target"

# 其它处理文件夹内容的操作
cd "$LOCAL_TMP_DIR/target"
# Code here

# 压缩
echo "切换目录：cd \"$LOCAL_TMP_DIR\""
cd "$LOCAL_TMP_DIR"
echo "执行：tar -cf target.tar target"
tar -cf target.tar target
echo "执行：gzip -9 target.tar"
gzip -9 target.tar

# 上传
echo "执行上传"
scp "$LOCAL_TMP_DIR/target.tar.gz" "$MACHINE_PREFIX:/tmp/$OK_FLAG.tar.gz"
echo "上传完成标志"
echo "">"$LOCAL_TMP_DIR/$OK_FLAG.txt"
scp "$LOCAL_TMP_DIR/$OK_FLAG.txt" "$MACHINE_PREFIX:/tmp/$OK_FLAG.txt"

# 删除临时文件
echo "切换目录：cd ~"
cd ~
echo "执行：rm -rf \"$LOCAL_TMP_DIR\""
rm -rf "$LOCAL_TMP_DIR"

echo "完成。"
