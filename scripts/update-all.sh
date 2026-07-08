#!/bin/bash
set -e

echo "🔄 更新所有子项目到最新版本..."
echo "================================"

git submodule update --remote --merge

echo ""
echo "✅ 更新完成！"
echo ""
echo "子项目状态："
git submodule status
