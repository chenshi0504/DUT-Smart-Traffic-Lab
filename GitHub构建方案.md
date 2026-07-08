# GitHub 仓库构建方案

## 项目背景

- **项目名称**: 轨道交通智能体
- **团队需求**: 团队协作开发
- **访问控制**: 部分内容公开，部分内容私密
- **目标**: 既要开源展示技术实力，又要保护核心代码和敏感数据

---

## 方案对比

### 方案一：双仓库独立架构 ⭐ 推荐

#### 仓库结构
```
1. rail-transit-agent (公开仓库)
   - 开源组件和通用功能
   - 公开文档和示例
   - 社区贡献代码

2. rail-transit-agent-private (私有仓库)
   - 核心业务逻辑
   - 配置文件和密钥
   - 敏感数据和内部文档
```

#### 详细目录规划

**公开仓库 (rail-transit-agent)**
```
rail-transit-agent/
├── README.md                    # 项目介绍
├── LICENSE                      # 开源协议
├── .gitignore
├── docs/                        # 公开文档
│   ├── getting-started.md       # 快速开始
│   ├── api-reference.md         # API文档
│   └── architecture.md          # 架构说明（公开部分）
├── examples/                    # 示例代码
│   ├── basic-usage/
│   ├── integration/
│   └── demos/
├── src/                         # 开源代码
│   ├── utils/                   # 通用工具函数
│   ├── components/              # UI组件（如有）
│   ├── types/                   # TypeScript类型定义
│   └── public-api/              # 公开的API接口
├── tests/                       # 公开功能的测试
└── package.json                 # 依赖配置
```

**私有仓库 (rail-transit-agent-private)**
```
rail-transit-agent-private/
├── README.md                    # 内部项目说明
├── .gitignore
├── .env.example                 # 环境变量模板
├── config/                      # 配置文件
│   ├── database.config.js
│   ├── api-keys.config.js       # API密钥配置
│   └── deployment.config.js
├── src/                         # 核心业务代码
│   ├── core/                    # 核心算法
│   ├── models/                  # AI模型
│   ├── services/                # 业务服务
│   ├── controllers/             # 控制器
│   └── internal-api/            # 内部API
├── data/                        # 敏感数据
│   ├── datasets/
│   └── training-data/
├── docs/                        # 内部文档
│   ├── internal-architecture.md
│   ├── deployment-guide.md
│   └── team-workflow.md
├── scripts/                     # 部署和维护脚本
├── tests/                       # 完整测试套件
└── package.json
```

#### 优点
- ✅ **权限清晰**: 公开/私有完全隔离
- ✅ **安全性高**: 敏感信息零泄露风险
- ✅ **管理简单**: 各自独立维护
- ✅ **灵活性强**: 可独立设置CI/CD
- ✅ **开源友好**: 外部贡献者不会接触到私有部分

#### 缺点
- ❌ 需要维护两个仓库
- ❌ 代码同步需要手动或脚本处理
- ❌ 团队成员需要clone两个仓库

#### 实施步骤
```bash
# 1. 创建公开仓库
mkdir rail-transit-agent
cd rail-transit-agent
git init
git remote add origin https://github.com/your-org/rail-transit-agent.git

# 2. 创建私有仓库
mkdir rail-transit-agent-private
cd rail-transit-agent-private
git init
git remote add origin https://github.com/your-org/rail-transit-agent-private.git

# 3. 建立同步脚本（可选）
# 创建 sync-public.sh 用于将私有仓库的公开部分同步到公开仓库
```

---

### 方案二：主仓库 + Submodules

#### 仓库结构
```
rail-transit-agent (公开仓库 - 主仓库)
├── private/  (Git Submodule -> 指向私有仓库)
└── 公开代码...
```

#### 目录示例
```
rail-transit-agent/
├── README.md
├── .gitmodules                  # Submodule配置
├── docs/
├── src/
│   ├── public/                  # 公开代码
│   └── private/                 # -> Git Submodule (私有仓库)
└── examples/
```

#### 优点
- ✅ **单一入口**: 团队成员只需clone一个主仓库
- ✅ **代码集中**: 开发时公开和私有代码在同一目录树
- ✅ **版本关联**: Submodule可以锁定特定版本

#### 缺点
- ❌ 外部用户clone时会看到private目录存在（但无法访问内容）
- ❌ Submodule管理较复杂，容易出错
- ❌ 团队成员需要额外的权限设置

#### 实施步骤
```bash
# 1. 创建主仓库（公开）
git init
git remote add origin https://github.com/your-org/rail-transit-agent.git

# 2. 创建私有仓库
# 在GitHub上创建 rail-transit-agent-core (私有)

# 3. 将私有仓库添加为submodule
git submodule add https://github.com/your-org/rail-transit-agent-core.git src/private

# 4. 团队成员clone时需要
git clone --recursive https://github.com/your-org/rail-transit-agent.git
```

---

### 方案三：Monorepo + 定期发布

#### 仓库结构
```
rail-transit-agent-internal (私有仓库 - 唯一真实仓库)
├── packages/
│   ├── public/              # 公开包
│   └── private/             # 私有包
└── 自动化脚本定期将public/推送到公开仓库
```

#### 目录示例
```
rail-transit-agent-internal/
├── README.md
├── .github/
│   └── workflows/
│       └── publish-public.yml   # 自动发布公开部分
├── packages/
│   ├── public/
│   │   ├── utils/
│   │   ├── components/
│   │   └── examples/
│   └── private/
│       ├── core/
│       ├── models/
│       └── services/
└── scripts/
    └── sync-to-public.sh        # 同步脚本
```

#### 优点
- ✅ **单一真相来源**: 只维护一个主仓库
- ✅ **代码复用**: 公开和私有代码可以方便互相引用
- ✅ **自动化**: 可以通过CI/CD自动发布公开部分

#### 缺点
- ❌ 需要编写和维护同步脚本
- ❌ 发布延迟（不是实时同步）
- ❌ 外部贡献需要额外处理（PR到公开仓库需要手动合并回私有仓库）

#### 实施步骤
```bash
# 1. 创建私有主仓库
mkdir rail-transit-agent-internal
cd rail-transit-agent-internal
git init
git remote add origin https://github.com/your-org/rail-transit-agent-internal.git

# 2. 创建公开仓库（空仓库）
# 在GitHub上创建 rail-transit-agent (公开)

# 3. 创建同步脚本
cat > scripts/sync-to-public.sh << 'EOF'
#!/bin/bash
# 将packages/public/的内容推送到公开仓库
git subtree push --prefix=packages/public public main
EOF

# 4. 添加公开仓库为remote
git remote add public https://github.com/your-org/rail-transit-agent.git
```

---

### 方案四：分支策略（不推荐）

#### 结构
```
同一个仓库，使用不同分支
- main (私有)
- public (公开)
```

#### 为什么不推荐
- ❌ GitHub不支持同一仓库的不同分支有不同可见性
- ❌ 容易误操作导致私有内容泄露
- ❌ 管理复杂，风险高

---

## 推荐决策树

```
开始
  │
  ├─ 需要频繁接受外部贡献？
  │   ├─ 是 → 方案一（双仓库）⭐
  │   └─ 否 ↓
  │
  ├─ 团队是否熟悉Git Submodules？
  │   ├─ 是 → 方案二（Submodules）
  │   └─ 否 ↓
  │
  ├─ 公开内容是否频繁更新？
  │   ├─ 是 → 方案一（双仓库）⭐
  │   └─ 否 → 方案三（Monorepo）
  │
  └─ 默认推荐 → 方案一（双仓库）⭐⭐⭐
```

---

## 安全最佳实践

### 1. .gitignore 配置
```gitignore
# 环境变量
.env
.env.local
.env.*.local

# 配置文件
config/*.key
config/*.secret
config/production.*

# 数据文件
data/
*.db
*.sqlite

# API密钥
**/api-keys.*
**/credentials.*

# 日志
logs/
*.log

# 临时文件
tmp/
temp/
```

### 2. GitHub Secrets
- 使用GitHub Actions Secrets存储敏感变量
- 不要在代码中硬编码密钥

### 3. 团队权限管理
```
公开仓库:
├── Maintainers (核心团队) → Admin
├── Contributors (贡献者)  → Write
└── Public               → Read

私有仓库:
├── Core Team           → Admin
├── Developers          → Write
└── Observers (如有)    → Read
```

### 4. Branch Protection
```yaml
保护规则:
- main分支需要PR审查
- 至少1个approver
- 通过CI检查后才能合并
- 禁止force push
```

---

## GitHub Actions 自动化示例

### 公开仓库的CI/CD (.github/workflows/ci.yml)
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
      - uses: actions/checkout@v3
      - name: Install dependencies
        run: npm install
      - name: Run tests
        run: npm test
      - name: Build
        run: npm run build
```

### 私有仓库的部署 (.github/workflows/deploy.yml)
```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to production
        env:
          API_KEY: ${{ secrets.API_KEY }}
          DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
        run: |
          npm run deploy
```

---

## 团队协作工作流

### 日常开发流程
```bash
# 1. 开发新功能
git checkout -b feature/new-feature

# 2. 提交代码
git add .
git commit -m "feat: add new feature"

# 3. 推送并创建PR
git push origin feature/new-feature

# 4. Code Review
# 团队成员审查代码

# 5. 合并到main
# 通过后合并
```

### 公开内容发布流程
```bash
# 方案一（双仓库）：
# 1. 在私有仓库完成开发
# 2. 将可公开的部分复制到公开仓库
# 3. 提交到公开仓库

# 方案三（Monorepo）：
# 1. 在私有仓库完成开发
# 2. 运行同步脚本
./scripts/sync-to-public.sh
```

---

## 成本考虑

| 方案 | 仓库数量 | 维护成本 | 复杂度 | GitHub费用 |
|------|---------|---------|--------|-----------|
| 方案一 | 2个 | 中 | 低 | 1个私有仓库费用 |
| 方案二 | 2个 | 高 | 高 | 1个私有仓库费用 |
| 方案三 | 2个 | 中 | 中 | 1个私有仓库费用 |

**GitHub定价参考**:
- 公开仓库: 免费
- 私有仓库: 
  - 个人账户: 免费（有限制）
  - 团队: $4/用户/月
  - 企业: $21/用户/月

---

## 最终推荐方案

### 🏆 推荐：方案一（双仓库独立架构）

**理由**:
1. ✅ 简单直观，风险最低
2. ✅ 安全性最高，零泄露风险
3. ✅ 适合团队协作和外部贡献
4. ✅ 维护成本可控
5. ✅ 符合业界最佳实践

**实施建议**:
- 公开仓库名称: `rail-transit-agent`
- 私有仓库名称: `rail-transit-agent-core` 或 `rail-transit-agent-private`
- 使用清晰的README说明公开仓库是完整项目的一部分
- 在私有仓库中建立向公开仓库同步的checklist

---

## 下一步行动

- [ ] 在GitHub创建组织账户（如果是团队项目）
- [ ] 创建公开仓库 `rail-transit-agent`
- [ ] 创建私有仓库 `rail-transit-agent-private`
- [ ] 设置团队成员权限
- [ ] 配置 .gitignore 文件
- [ ] 建立分支保护规则
- [ ] 设置GitHub Actions
- [ ] 编写贡献指南 (CONTRIBUTING.md)
- [ ] 创建Issue和PR模板

---

**文档版本**: v1.0  
**最后更新**: 2026-07-08  
**维护者**: （待补充）
