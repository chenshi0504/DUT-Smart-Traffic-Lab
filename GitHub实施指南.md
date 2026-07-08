# GitHub仓库实施指南

## 📋 概述

本文档提供在GitHub上创建和配置"智慧交通管理与技术应用团队"仓库的详细步骤。

---

## 第一阶段：在GitHub创建仓库

### 1. 创建GitHub账户/组织

#### 选项A：使用个人账户（简单）

1. 登录 https://github.com （使用 chenshi_edu@gmail.com）
2. 直接在个人账户下创建仓库

#### 选项B：创建组织账户（推荐）✅

1. 访问 https://github.com/organizations/plan
2. 点击 **"Create a free organization"**
3. 填写信息：
   - **Organization name**: `smart-traffic-team` 或 `intelligent-traffic-lab`
   - **Contact email**: chenshi_edu@gmail.com
   - **Organization type**: Free (适合学术研究)
4. 点击 **"Next"** 并完成设置
5. 邀请团队成员加入组织

### 2. 创建主仓库

1. 在GitHub上点击 **"New repository"**
2. 填写仓库信息：
   - **Repository name**: `smart-traffic-management`
   - **Description**: 智慧交通管理与技术应用团队 - 研究项目门户
   - **Visibility**: 
     - 🔓 **Public** (推荐) - 展示团队，吸引合作
     - 🔒 **Private** - 完全内部
   - ❌ **不要** 勾选 "Initialize this repository with a README"（我们已经在本地创建）
3. 点击 **"Create repository"**

### 3. 创建四个私有子仓库

重复以下步骤4次，创建私有子仓库：

#### 子仓库1：土地利用与交通一体化
- **Name**: `land-use-transport-integration`
- **Description**: 土地利用与交通一体化研究
- **Visibility**: 🔒 **Private**

#### 子仓库2：车路云一体化平台
- **Name**: `vehicle-road-cloud-platform`
- **Description**: 面向车路云一体化的交通管控教学与实验平台
- **Visibility**: 🔒 **Private**

#### 子仓库3：大模型信号优化
- **Name**: `llm-signal-optimization`
- **Description**: 大模型驱动的信号优化控制
- **Visibility**: 🔒 **Private**

#### 子仓库4：硬件在环小车
- **Name**: `hardware-in-loop-vehicle`
- **Description**: 硬件在环与嵌入式小车开发
- **Visibility**: 🔒 **Private**

---

## 第二阶段：本地推送到GitHub

### 1. 推送主仓库

```bash
# 在本地项目目录 (d:\轨道交通智能体)
cd "d:\轨道交通智能体"

# 添加远程仓库（替换YOUR_ORG为你的组织名或用户名）
git remote add origin https://github.com/YOUR_ORG/smart-traffic-management.git

# 推送到GitHub
git branch -M main
git push -u origin main
```

**如果遇到认证问题**：
```bash
# 方法1: 使用Personal Access Token (推荐)
# 1. GitHub -> Settings -> Developer settings -> Personal access tokens -> Tokens (classic)
# 2. Generate new token, 勾选 repo 权限
# 3. 使用token作为密码

# 方法2: 使用SSH
ssh-keygen -t ed25519 -C "chenshi_edu@gmail.com"
# 将 ~/.ssh/id_ed25519.pub 内容添加到 GitHub -> Settings -> SSH keys
git remote set-url origin git@github.com:YOUR_ORG/smart-traffic-management.git
```

### 2. 初始化子仓库

为每个子仓库创建初始内容：

#### 子仓库1：土地利用与交通一体化

```bash
# 创建临时目录
cd ..
mkdir land-use-transport-integration
cd land-use-transport-integration

# 初始化
git init
mkdir -p docs src data notebooks results tests

# 复制模板README
cp "../轨道交通智能体/resources/子项目模板-土地利用与交通一体化.md" README.md

# 创建.gitignore
cp "../轨道交通智能体/.gitignore" .gitignore

# 创建requirements.txt
cat > requirements.txt << 'EOF'
numpy>=1.21.0
pandas>=1.3.0
geopandas>=0.10.0
shapely>=1.8.0
osmnx>=1.1.0
networkx>=2.6.0
matplotlib>=3.4.0
seaborn>=0.11.0
folium>=0.12.0
jupyter>=1.0.0
EOF

# 提交
git add .
git commit -m "Initial commit: 土地利用与交通一体化研究项目

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"

# 推送到GitHub
git remote add origin https://github.com/YOUR_ORG/land-use-transport-integration.git
git branch -M main
git push -u origin main
```

#### 子仓库2：车路云一体化平台

```bash
cd ..
mkdir vehicle-road-cloud-platform
cd vehicle-road-cloud-platform

git init
mkdir -p docs src/{vehicle,road,cloud,common} experiments simulation deployment tests

cp "../轨道交通智能体/resources/子项目模板-车路云一体化平台.md" README.md
cp "../轨道交通智能体/.gitignore" .gitignore

cat > requirements.txt << 'EOF'
fastapi>=0.95.0
uvicorn>=0.21.0
paho-mqtt>=1.6.0
websockets>=10.4
numpy>=1.21.0
pandas>=1.3.0
pytest>=7.2.0
EOF

git add .
git commit -m "Initial commit: 车路云一体化交通管控平台

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"

git remote add origin https://github.com/YOUR_ORG/vehicle-road-cloud-platform.git
git branch -M main
git push -u origin main
```

#### 子仓库3：大模型信号优化

```bash
cd ..
mkdir llm-signal-optimization
cd llm-signal-optimization

git init
mkdir -p docs src/{models,data_processing,training,inference} configs experiments evaluation simulation tests

cp "../轨道交通智能体/resources/子项目模板-大模型信号优化.md" README.md
cp "../轨道交通智能体/.gitignore" .gitignore

cat > requirements.txt << 'EOF'
torch>=2.0.0
transformers>=4.30.0
gymnasium>=0.28.0
stable-baselines3>=2.0.0
traci>=1.17.0
numpy>=1.21.0
pandas>=1.3.0
wandb>=0.15.0
tensorboard>=2.13.0
EOF

git add .
git commit -m "Initial commit: 大模型驱动的信号优化控制

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"

git remote add origin https://github.com/YOUR_ORG/llm-signal-optimization.git
git branch -M main
git push -u origin main
```

#### 子仓库4：硬件在环小车

```bash
cd ..
mkdir hardware-in-loop-vehicle
cd hardware-in-loop-vehicle

git init
mkdir -p docs firmware/{stm32,raspberry_pi,arduino} hil-simulation vehicle-platform ros-packages experiments tools tests

cp "../轨道交通智能体/resources/子项目模板-硬件在环小车.md" README.md
cp "../轨道交通智能体/.gitignore" .gitignore

cat > requirements.txt << 'EOF'
numpy>=1.21.0
opencv-python>=4.5.0
pyserial>=3.5
matplotlib>=3.4.0
rospy  # ROS Python接口
EOF

git add .
git commit -m "Initial commit: 硬件在环与嵌入式小车开发

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"

git remote add origin https://github.com/YOUR_ORG/hardware-in-loop-vehicle.git
git branch -M main
git push -u origin main
```

---

## 第三阶段：添加Submodules

### 回到主仓库，添加子模块

```bash
cd "d:\轨道交通智能体"

# 添加四个子仓库作为submodules
git submodule add https://github.com/YOUR_ORG/land-use-transport-integration.git projects/land-use-transport

git submodule add https://github.com/YOUR_ORG/vehicle-road-cloud-platform.git projects/vehicle-road-cloud

git submodule add https://github.com/YOUR_ORG/llm-signal-optimization.git projects/llm-signal-optimization

git submodule add https://github.com/YOUR_ORG/hardware-in-loop-vehicle.git projects/hardware-in-loop

# 提交submodule配置
git add .gitmodules projects/
git commit -m "Add research project submodules

- 土地利用与交通一体化
- 车路云一体化平台
- 大模型信号优化
- 硬件在环小车

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"

git push
```

---

## 第四阶段：配置GitHub设置

### 1. 设置仓库权限

#### 主仓库（如果是Public）
1. 进入仓库 -> Settings -> Collaborators
2. 添加团队成员，赋予 **Write** 或 **Admin** 权限

#### 私有子仓库
1. 每个私有仓库 -> Settings -> Collaborators
2. 添加团队成员
3. 或使用组织的Team功能统一管理

### 2. 配置Branch Protection

1. 进入仓库 -> Settings -> Branches
2. 点击 **"Add branch protection rule"**
3. 配置：
   - **Branch name pattern**: `main`
   - ✅ **Require a pull request before merging**
   - ✅ **Require approvals**: 1
   - ✅ **Require status checks to pass**
   - ❌ **不要** 勾选 "Include administrators"（方便初期快速迭代）

### 3. 创建Issue模板（可选）

在主仓库创建 `.github/ISSUE_TEMPLATE/`：

```bash
cd "d:\轨道交通智能体"
mkdir -p .github/ISSUE_TEMPLATE
```

创建bug报告模板：
```bash
cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug报告
about: 报告一个问题帮助我们改进
title: '[BUG] '
labels: bug
---

## Bug描述
清晰简洁地描述bug

## 复现步骤
1. 
2. 
3. 

## 期望行为
应该发生什么

## 实际行为
实际发生了什么

## 环境
- OS: 
- Python版本: 
- 相关依赖版本: 
EOF
```

---

## 第五阶段：团队协作设置

### 1. 团队成员首次克隆

```bash
# 克隆完整项目（包含所有submodules）
git clone --recursive https://github.com/YOUR_ORG/smart-traffic-management.git

cd smart-traffic-management

# 运行初始化脚本
chmod +x scripts/*.sh
./scripts/setup-all.sh
```

### 2. 配置Git用户信息

每个团队成员需要配置：
```bash
git config --global user.name "你的姓名"
git config --global user.email "你的邮箱@example.com"
```

---

## 📝 替换清单

在执行上述命令前，需要替换以下占位符：

| 占位符 | 替换为 | 示例 |
|--------|--------|------|
| `YOUR_ORG` | 你的GitHub组织名或用户名 | `smart-traffic-team` |
| `chenshi_edu@gmail.com` | 实际管理员邮箱 | 保持不变或修改 |

---

## ✅ 验证清单

完成后，检查以下项：

- [ ] 主仓库已在GitHub上创建并推送
- [ ] 四个私有子仓库已创建并推送
- [ ] Submodules已正确配置（`.gitmodules`文件存在）
- [ ] 团队成员已被邀请并接受邀请
- [ ] Branch protection已设置
- [ ] 本地可以正常克隆和更新
- [ ] 脚本文件有执行权限（Linux/Mac需要`chmod +x`）

---

## 🔧 故障排除

### 问题1：推送时要求认证

**解决方案**：使用Personal Access Token (PAT)
1. GitHub -> Settings -> Developer settings -> Personal access tokens
2. Generate new token (classic)
3. 勾选 `repo` 权限
4. 复制token
5. 推送时使用token作为密码

### 问题2：Submodule无法访问

**原因**：没有私有仓库权限

**解决方案**：
- 确认GitHub账户已被添加到私有仓库的Collaborators
- 或使用SSH密钥认证

### 问题3：Windows下脚本无法执行

**解决方案**：
```bash
# 使用Git Bash执行
bash scripts/setup-all.sh

# 或使用WSL
wsl bash scripts/setup-all.sh
```

---

## 📞 获取帮助

如有问题，联系：
- **项目负责人**: chenshi_edu@gmail.com
- **GitHub文档**: https://docs.github.com/

---

**文档版本**: v1.0  
**创建日期**: 2026-07-08  
**适用项目**: 智慧交通管理与技术应用团队
