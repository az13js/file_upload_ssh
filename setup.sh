#!/bin/bash

# 用来做上传完成标志的文件名，与上传的保持一致
OK_FLAG="4918FCCBE598057E870BB8C15CD39119"
# 解压后存放的目录
TARGET_DIR="/tmp"
# 覆盖的文件夹名称
DIR_NAME="test"
# 临时目录
LOCAL_TMP_DIR="/tmp/$RANDOM-$RANDOM-$RANDOM-$RANDOM-$RANDOM"

echo "临时目录为：$LOCAL_TMP_DIR"

while (true)
do
    if [ -f "/tmp/$OK_FLAG.txt" ];then
        # 检测参数是否正常
        if [ -d "$LOCAL_TMP_DIR" ];then
            echo "临时目录（$LOCAL_TMP_DIR）存在，不执行更新。"
        else
            echo "开始执行文件处理"
            mkdir -p "$LOCAL_TMP_DIR"
            mv "/tmp/$OK_FLAG.tar.gz" "$LOCAL_TMP_DIR/"
            cd "$LOCAL_TMP_DIR"
            tar --touch -axf "$OK_FLAG.tar.gz"
            # 执行重命名的操作
            mv target "$DIR_NAME"
            cp -r "$DIR_NAME" "$TARGET_DIR/"
            echo "完成，删除临时文件"
            cd ~
            rm -fr "$LOCAL_TMP_DIR"
            rm -f "/tmp/$OK_FLAG.txt"
        fi
    fi
    sleep 1
done
