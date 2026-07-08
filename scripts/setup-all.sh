#!/bin/bash
set -e

echo "🚀 智慧交通团队项目初始化..."
echo "================================"

# 检查git配置
if [ -z "$(git config user.email)" ]; then
    echo "⚠️  配置Git用户信息..."
    git config --global user.email "chenshi_edu@gmail.com"
    git config --global user.name "智慧交通团队"
fi

# 初始化所有submodules
echo "📦 初始化子项目..."
git submodule update --init --recursive

echo ""
echo "✅ 初始化完成！"
echo ""
echo "可用的子项目："
echo "  1. projects/land-use-transport         - 土地利用与交通一体化"
echo "  2. projects/vehicle-road-cloud         - 车路云一体化平台"
echo "  3. projects/llm-signal-optimization    - 大模型信号优化"
echo "  4. projects/hardware-in-loop           - 硬件在环小车"
echo ""
echo "开始开发："
echo "  cd projects/llm-signal-optimization"
