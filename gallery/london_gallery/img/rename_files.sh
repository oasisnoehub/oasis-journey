#!/bin/bash

# 遍历当前目录下所有以 "freecompress-" 开头的 .jpeg 文件
for file in freecompress-*.jpeg; do
    # 检查文件是否存在（避免没有匹配文件时报错）
    if [[ -f "$file" ]]; then
        # 提取文件名中的 "pc014" 部分
        new_name=$(echo "$file" | sed 's/^freecompress-//')
        # 重命名文件
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done

echo "All files have been renamed."
