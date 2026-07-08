# 环境搭建指南

本指南帮助团队成员快速搭建开发环境。

## 前置要求

### 必需工具
- **Git**: 版本控制
  - Windows: [Git for Windows](https://git-scm.com/download/win)
  - Linux/Mac: 通常已预装
  
- **Python**: 3.8+
  - 下载: [Python官网](https://www.python.org/downloads/)
  
- **代码编辑器**（任选其一）:
  - [VS Code](https://code.visualstudio.com/)
  - [PyCharm](https://www.jetbrains.com/pycharm/)
  - [Sublime Text](https://www.sublimetext.com/)

### 可选工具
- **MATLAB**: R2020a+ (用于部分仿真项目)
- **Docker**: 容器化部署
- **ROS**: 机器人操作系统（硬件在环项目需要）

---

## 步骤 1: 克隆项目

### 团队成员（有所有权限）

```bash
# 克隆主仓库及所有子模块
git clone --recursive https://github.com/YOUR_ORG/smart-traffic-management.git

# 进入项目目录
cd smart-traffic-management
```

如果已经克隆但没有子模块：
```bash
git submodule update --init --recursive
```

---

## 步骤 2: 配置 Git

```bash
# 设置用户信息
git config --global user.name "你的姓名"
git config --global user.email "你的邮箱@example.com"

# 查看配置
git config --list
```

---

## 步骤 3: Python 环境设置

### 创建虚拟环境

```bash
# 使用 venv（Python 3.3+自带）
python -m venv venv

# 激活虚拟环境
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate
```

### 安装依赖

```bash
# 如果项目有 requirements.txt
pip install -r requirements.txt

# 常用库（根据项目需求）
pip install numpy pandas matplotlib scikit-learn
pip install torch torchvision  # PyTorch
pip install tensorflow         # TensorFlow
pip install geopandas folium   # 地理数据处理
```

---

## 步骤 4: 项目特定配置

### 项目 1: 土地利用与交通一体化

```bash
cd projects/land-use-transport

# 安装地理分析库
pip install geopandas shapely fiona
pip install osmnx networkx

# 安装可视化工具
pip install folium plotly
```

### 项目 2: 车路云一体化平台

```bash
cd projects/vehicle-road-cloud

# 安装web框架（如有）
pip install flask fastapi uvicorn

# 安装通信库
pip install paho-mqtt websockets

# Docker环境（可选）
docker-compose up -d
```

### 项目 3: 大模型信号优化

```bash
cd projects/llm-signal-optimization

# 安装深度学习框架
pip install torch torchvision
pip install transformers  # Hugging Face

# 安装强化学习库
pip install gym stable-baselines3

# 交通仿真工具
pip install traci  # SUMO的Python接口
```

### 项目 4: 硬件在环小车

```bash
cd projects/hardware-in-loop

# 安装ROS（Linux推荐）
# Ubuntu 20.04:
sudo apt install ros-noetic-desktop-full

# Python ROS接口
pip install rospy

# 串口通信
pip install pyserial

# 图像处理
pip install opencv-python
```

---

## 步骤 5: 开发工具配置

### VS Code 推荐扩展

- Python (Microsoft)
- GitLens
- Jupyter
- Docker
- Remote - SSH (远程开发)
- TODO Highlight

### VS Code 设置 (settings.json)

```json
{
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "black",
    "editor.formatOnSave": true,
    "files.exclude": {
        "**/__pycache__": true,
        "**/*.pyc": true
    }
}
```

---

## 步骤 6: 仿真软件安装（可选）

### SUMO (交通仿真)
```bash
# Ubuntu
sudo apt install sumo sumo-tools sumo-doc

# Windows
# 从官网下载: https://www.eclipse.org/sumo/
```

### CARLA (自动驾驶仿真)
```bash
# 从官网下载预编译版本
# https://github.com/carla-simulator/carla/releases

# Python API
pip install carla
```

---

## 步骤 7: 运行测试

```bash
# 运行测试确保环境配置正确
python -m pytest tests/

# 或运行示例
python examples/basic_example.py
```

---

## 常见问题

### Q: Git submodule 更新失败
```bash
# 解决方法：
git submodule sync
git submodule update --init --recursive
```

### Q: Python 包安装失败
```bash
# 使用国内镜像源
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple <package-name>

# 或永久配置
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

### Q: 权限问题（无法访问私有子仓库）
- 确认你的GitHub账户已被添加到团队
- 配置SSH密钥或使用Personal Access Token
- 联系团队管理员：chenshi_edu@gmail.com

### Q: CUDA / GPU 相关问题
```bash
# 检查CUDA版本
nvcc --version

# 安装对应版本的PyTorch
# 参考: https://pytorch.org/get-started/locally/
```

---

## 开发工作流

### 日常开发

```bash
# 1. 创建新分支
git checkout -b feature/your-feature-name

# 2. 进行开发
# 编辑代码...

# 3. 提交更改
git add .
git commit -m "feat: add new feature"

# 4. 推送到远程
git push origin feature/your-feature-name

# 5. 在GitHub上创建Pull Request
```

### 更新子模块

```bash
# 进入子模块
cd projects/llm-signal-optimization

# 更新代码
git pull origin main

# 回到主仓库
cd ../..

# 更新主仓库对子模块的引用
git add projects/llm-signal-optimization
git commit -m "Update llm-signal-optimization submodule"
git push
```

---

## 性能优化建议

### Python 性能
- 使用 NumPy 向量化操作
- 使用 `multiprocessing` 并行计算
- 考虑使用 Cython 或 Numba 加速

### 大数据处理
- 使用 Dask 处理大型数据集
- 使用数据库（PostgreSQL + PostGIS）存储地理数据
- 批处理而非逐条处理

### GPU 加速
- 确保PyTorch/TensorFlow使用GPU
- 合理设置batch size
- 使用混合精度训练

---

## 获取帮助

- 📖 查看项目文档: `docs/`
- 💬 团队交流: （待补充通讯方式）
- 📧 技术支持: chenshi_edu@gmail.com
- 🐛 提交Issue: GitHub Issues

---

**最后更新**: 2026-07-08
