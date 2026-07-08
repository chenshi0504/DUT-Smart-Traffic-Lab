# Monorepo + Submodules 混合访问控制方案

## 方案概述

使用 **Git Submodules** 实现一个主仓库包含多个子仓库，每个子仓库可以独立设置访问权限。

## 架构设计

### 仓库结构

```
rail-transit-monorepo (主仓库 - 建议设为私有)
│
├── .gitmodules                    # Submodules配置文件
├── README.md                      # 项目总览
├── docs/                          # 总体文档
│   ├── architecture.md
│   └── setup-guide.md
│
├── modules/                       # 所有子模块
│   ├── public-api/                # Submodule - 公开 ✅
│   ├── web-ui/                    # Submodule - 公开 ✅
│   ├── core-engine/               # Submodule - 私有 🔒
│   ├── ai-models/                 # Submodule - 私有 🔒
│   ├── data-processing/           # Submodule - 私有 🔒
│   └── utils/                     # Submodule - 公开 ✅
│
├── config/                        # 主仓库配置（私有）
│   ├── docker-compose.yml
│   └── deployment.config.js
│
├── scripts/                       # 管理脚本
│   ├── setup-all.sh               # 初始化所有submodules
│   ├── update-all.sh              # 更新所有submodules
│   └── sync-public.sh             # 同步公开模块
│
└── package.json / requirements.txt # 根依赖
```

### 子仓库列表

| 子仓库名称 | 访问权限 | 用途 | GitHub地址 |
|-----------|---------|------|-----------|
| `public-api` | 公开 | 公开API接口和文档 | `github.com/org/rail-public-api` |
| `web-ui` | 公开 | 前端UI组件 | `github.com/org/rail-web-ui` |
| `core-engine` | 私有 | 核心调度引擎 | `github.com/org/rail-core-engine` |
| `ai-models` | 私有 | AI模型和训练代码 | `github.com/org/rail-ai-models` |
| `data-processing` | 私有 | 数据处理逻辑 | `github.com/org/rail-data-processing` |
| `utils` | 公开 | 通用工具库 | `github.com/org/rail-utils` |

---

## 实施步骤

### 第一步：创建所有子仓库

```bash
# 1. 在GitHub上创建以下仓库：
# 公开仓库：
- rail-public-api
- rail-web-ui  
- rail-utils

# 私有仓库：
- rail-core-engine
- rail-ai-models
- rail-data-processing
```

### 第二步：创建主仓库

```bash
# 1. 在本地初始化主仓库
mkdir rail-transit-monorepo
cd rail-transit-monorepo
git init

# 2. 创建基础结构
mkdir -p modules docs config scripts

# 3. 创建README
cat > README.md << 'EOF'
# 轨道交通智能体 Monorepo

本项目使用 Submodules 架构，包含多个独立模块。

## 模块说明
- `modules/public-api/` - 公开API（公开仓库）
- `modules/web-ui/` - Web界面（公开仓库）
- `modules/core-engine/` - 核心引擎（私有仓库）🔒
- `modules/ai-models/` - AI模型（私有仓库）🔒
- `modules/data-processing/` - 数据处理（私有仓库）🔒
- `modules/utils/` - 工具库（公开仓库）

## 团队成员快速开始
\`\`\`bash
git clone --recursive https://github.com/your-org/rail-transit-monorepo.git
cd rail-transit-monorepo
./scripts/setup-all.sh
\`\`\`

## 外部贡献者
如果你无权访问私有模块，可以：
\`\`\`bash
git clone https://github.com/your-org/rail-transit-monorepo.git
cd rail-transit-monorepo
git submodule update --init modules/public-api
git submodule update --init modules/web-ui
git submodule update --init modules/utils
\`\`\`
EOF

# 4. 在GitHub上创建主仓库并推送
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/your-org/rail-transit-monorepo.git
git push -u origin main
```

### 第三步：添加 Submodules

```bash
# 进入主仓库目录
cd rail-transit-monorepo

# 添加公开子模块
git submodule add https://github.com/your-org/rail-public-api.git modules/public-api
git submodule add https://github.com/your-org/rail-web-ui.git modules/web-ui
git submodule add https://github.com/your-org/rail-utils.git modules/utils

# 添加私有子模块
git submodule add https://github.com/your-org/rail-core-engine.git modules/core-engine
git submodule add https://github.com/your-org/rail-ai-models.git modules/ai-models
git submodule add https://github.com/your-org/rail-data-processing.git modules/data-processing

# 提交submodule配置
git add .
git commit -m "Add all submodules"
git push
```

### 第四步：创建管理脚本

```bash
# setup-all.sh - 初始化所有submodules
cat > scripts/setup-all.sh << 'EOF'
#!/bin/bash
set -e

echo "🚀 初始化所有子模块..."

# 初始化并更新所有submodules
git submodule update --init --recursive

echo "📦 安装依赖..."
# 根据项目需要添加依赖安装命令
# npm install 或 pip install -r requirements.txt

echo "✅ 设置完成！"
EOF

chmod +x scripts/setup-all.sh

# update-all.sh - 更新所有submodules
cat > scripts/update-all.sh << 'EOF'
#!/bin/bash
set -e

echo "🔄 更新所有子模块..."

# 更新所有submodules到最新版本
git submodule update --remote --merge

echo "✅ 更新完成！"
EOF

chmod +x scripts/update-all.sh

# setup-public.sh - 只初始化公开模块（供外部贡献者使用）
cat > scripts/setup-public.sh << 'EOF'
#!/bin/bash
set -e

echo "🚀 初始化公开模块..."

# 只初始化公开的submodules
git submodule update --init modules/public-api
git submodule update --init modules/web-ui
git submodule update --init modules/utils

echo "✅ 公开模块设置完成！"
echo "ℹ️  私有模块需要额外权限才能访问"
EOF

chmod +x scripts/setup-public.sh
```

---

## .gitmodules 文件示例

```ini
[submodule "modules/public-api"]
    path = modules/public-api
    url = https://github.com/your-org/rail-public-api.git
    branch = main

[submodule "modules/web-ui"]
    path = modules/web-ui
    url = https://github.com/your-org/rail-web-ui.git
    branch = main

[submodule "modules/utils"]
    path = modules/utils
    url = https://github.com/your-org/rail-utils.git
    branch = main

[submodule "modules/core-engine"]
    path = modules/core-engine
    url = https://github.com/your-org/rail-core-engine.git
    branch = main

[submodule "modules/ai-models"]
    path = modules/ai-models
    url = https://github.com/your-org/rail-ai-models.git
    branch = main

[submodule "modules/data-processing"]
    path = modules/data-processing
    url = https://github.com/your-org/rail-data-processing.git
    branch = main
```

---

## 使用场景

### 场景一：团队成员（有所有权限）

```bash
# 1. Clone完整项目
git clone --recursive https://github.com/your-org/rail-transit-monorepo.git
cd rail-transit-monorepo

# 2. 运行设置脚本
./scripts/setup-all.sh

# 3. 开始开发
# 所有模块都可以访问和修改
```

### 场景二：外部贡献者（只有公开仓库权限）

```bash
# 1. Clone主仓库
git clone https://github.com/your-org/rail-transit-monorepo.git
cd rail-transit-monorepo

# 2. 只初始化公开模块
./scripts/setup-public.sh

# 3. 可以看到的结构：
modules/
├── public-api/          ✅ 完整内容
├── web-ui/              ✅ 完整内容
├── core-engine/         ⚠️ 空目录（.git文件指向私有仓库）
├── ai-models/           ⚠️ 空目录
├── data-processing/     ⚠️ 空目录
└── utils/               ✅ 完整内容
```

### 场景三：在子模块中开发

```bash
# 进入某个子模块
cd modules/public-api

# 子模块是独立的Git仓库，可以正常操作
git checkout -b feature/new-api
# 修改代码...
git add .
git commit -m "feat: add new API endpoint"
git push origin feature/new-api

# 回到主仓库
cd ../..

# 更新主仓库对子模块的引用
git add modules/public-api
git commit -m "Update public-api submodule"
git push
```

---

## 权限管理

### GitHub仓库权限设置

**主仓库 (rail-transit-monorepo)**
- 建议设为：**私有**
- 团队成员：Admin / Write 权限
- 外部贡献者：可选择性授予 Read 权限

**公开子仓库**
- 设为：**Public**
- 所有人：Read 权限
- 团队成员：Write / Admin 权限

**私有子仓库**
- 设为：**Private**
- 只有团队成员：Write / Admin 权限
- 外部用户：无权限

### 团队权限表

| 角色 | 主仓库 | 公开子仓库 | 私有子仓库 |
|------|-------|-----------|-----------|
| 核心团队 | Admin | Admin | Admin |
| 开发者 | Write | Write | Write |
| 外部贡献者 | Read (可选) | Write | ❌ 无权限 |
| 公众 | ❌ | Read | ❌ |

---

## 优势与挑战

### ✅ 优势

1. **灵活的访问控制**
   - 每个模块独立设置权限
   - 公开与私有代码并存

2. **代码组织清晰**
   - 模块化架构
   - 统一的入口点

3. **独立开发**
   - 每个模块可以独立开发、测试、部署
   - 有独立的版本控制

4. **选择性共享**
   - 可以开源部分技术
   - 保护核心知识产权

### ⚠️ 挑战

1. **学习曲线**
   - 团队需要理解 Submodules 机制
   - 需要额外的命令和工作流

2. **同步复杂度**
   - 需要管理主仓库和子仓库的版本关系
   - 更新操作相对复杂

3. **CI/CD 配置**
   - 需要特殊配置来处理 submodules
   - 权限管理更复杂

4. **潜在的版本冲突**
   - 不同子模块可能依赖不同版本的共同依赖

---

## 常用命令速查

```bash
# 克隆包含submodules的仓库
git clone --recursive <repo-url>

# 已克隆，后续初始化submodules
git submodule update --init --recursive

# 更新所有submodules到最新
git submodule update --remote --merge

# 只更新特定submodule
git submodule update --remote modules/public-api

# 查看submodules状态
git submodule status

# 在所有submodules中执行命令
git submodule foreach 'git checkout main'
git submodule foreach 'git pull'

# 移除submodule
git submodule deinit modules/some-module
git rm modules/some-module
rm -rf .git/modules/modules/some-module
```

---

## CI/CD 配置示例

### GitHub Actions (.github/workflows/ci.yml)

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        with:
          submodules: recursive  # 关键：递归克隆submodules
          token: ${{ secrets.GH_PAT }}  # 需要能访问私有仓库的token

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: |
          npm install
          
      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build
```

**注意**: 需要创建一个 Personal Access Token (PAT) 有权限访问所有子仓库。

---

## 最佳实践

### 1. 版本锁定
```bash
# 主仓库应该锁定submodules的特定commit
# 而不是总是指向最新版本
git submodule update --init  # 使用锁定的版本
# 而不是
git submodule update --remote  # 总是拉取最新（不稳定）
```

### 2. 文档说明
在主仓库的 README 中清楚说明：
- 哪些模块是公开的
- 哪些模块需要权限
- 如何获取权限
- 外部贡献者如何参与

### 3. 自动化脚本
提供便捷的脚本来处理常见操作：
- 初始化项目
- 更新依赖
- 运行测试
- 部署

### 4. 定期同步
建立流程定期同步主仓库对子模块的引用：
```bash
# 每周/每月执行
git submodule update --remote --merge
git add .
git commit -m "Update submodules to latest"
git push
```

---

## 替代方案对比

| 方案 | 灵活性 | 复杂度 | 适用场景 |
|------|-------|--------|---------|
| **Submodules（本方案）** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 需要细粒度权限控制 |
| **双仓库** | ⭐⭐⭐ | ⭐⭐ | 简单的公开/私有分离 |
| **Monorepo（单仓库）** | ⭐⭐ | ⭐ | 完全私有或完全公开 |

---

## 决策建议

### 选择 Submodules 方案，如果：
✅ 需要多个模块有不同的访问权限  
✅ 模块需要独立开发和版本管理  
✅ 团队有 Git 进阶使用经验  
✅ 希望部分开源、部分私有  

### 选择双仓库方案，如果：
✅ 只需要简单的公开/私有二分  
✅ 团队 Git 经验较少  
✅ 希望最小化复杂度  

---

## 下一步行动清单

- [ ] 决定主仓库是否设为私有
- [ ] 规划子模块的划分（哪些公开、哪些私有）
- [ ] 在GitHub创建所有子仓库
- [ ] 在GitHub创建主仓库
- [ ] 配置子模块作为 submodules
- [ ] 编写管理脚本
- [ ] 配置 CI/CD（处理 submodules）
- [ ] 编写团队开发文档
- [ ] 设置团队成员权限
- [ ] 测试外部用户访问场景

---

**文档版本**: v1.0  
**创建日期**: 2026-07-08  
**适用项目**: 轨道交通智能体
