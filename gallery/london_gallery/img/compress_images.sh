#!/bin/bash

# 定义文件夹路径
IMG_DIR="./"

# 定义最大文件大小 (1MB)
MAX_SIZE=1048576  # 1MB in bytes

# 定义目标文件大小 (500KB)
TARGET_SIZE=512000  # 500KB in bytes

# 遍历img文件夹下的所有.jpeg文件
for file in "$IMG_DIR"/*.jpeg; do
    # 获取文件大小（macOS兼容）
    file_size=$(stat -f%z "$file")

    # 检查是否成功获取文件大小
    if [ -z "$file_size" ]; then
        echo "无法获取文件大小: $file"
        continue
    fi

    # 如果文件大小超过1MB
    if [ "$file_size" -gt "$MAX_SIZE" ]; then
        echo "压缩文件: $file (原始大小: $file_size bytes)"

        # 使用magick命令压缩图片（ImageMagick 7.x）
        magick "$file" -define jpeg:extent="$TARGET_SIZE" "$file"

        # 获取压缩后的文件大小
        new_size=$(stat -f%z "$file")
        echo "压缩后大小: $new_size bytes"
    fi
done

echo "所有图片处理完成 ✅"
