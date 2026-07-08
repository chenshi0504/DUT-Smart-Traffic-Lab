#!/bin/bash

echo "📊 检查所有子项目状态..."
echo "================================"

for dir in projects/*/; do
    if [ -d "$dir/.git" ]; then
        echo ""
        echo "📁 $(basename $dir)"
        echo "---"
        cd "$dir"
        git status -s
        echo "当前分支: $(git branch --show-current)"
        cd - > /dev/null
    fi
done

echo ""
echo "================================"
echo "主仓库状态："
git status -s
