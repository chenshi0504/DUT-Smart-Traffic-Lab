# 贡献指南

感谢你对智慧交通管理与技术应用团队项目的关注！

## 🤝 如何贡献

### 团队成员

团队成员可以直接访问所有私有仓库，并参与各个研究项目的开发。

### 外部贡献者

由于本项目的核心研究内容为私有仓库，外部贡献者的参与方式有限。如果您有兴趣合作，请联系：chenshi_edu@gmail.com

---

## 📋 贡献类型

### 代码贡献
- 新功能开发
- Bug修复
- 性能优化
- 代码重构

### 文档贡献
- 完善项目文档
- 编写教程和示例
- 翻译文档
- 修正错误

### 测试贡献
- 编写测试用例
- 报告Bug
- 验证修复

### 其他贡献
- 提出改进建议
- 参与讨论
- 分享使用经验

---

## 🔄 开发工作流

### 1. Fork 和 Clone（如适用）

```bash
# Clone 你fork的仓库
git clone https://github.com/YOUR_USERNAME/repository-name.git
cd repository-name

# 添加上游仓库
git remote add upstream https://github.com/smart-traffic-team/repository-name.git
```

### 2. 创建分支

```bash
# 从main分支创建新分支
git checkout -b feature/your-feature-name

# 分支命名规范：
# feature/xxx  - 新功能
# fix/xxx      - Bug修复
# docs/xxx     - 文档更新
# refactor/xxx - 代码重构
# test/xxx     - 测试相关
```

### 3. 开发和提交

```bash
# 进行开发
# ...

# 提交代码
git add .
git commit -m "feat: add new feature"
```

#### Commit Message 规范

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type类型：**
- `feat`: 新功能
- `fix`: Bug修复
- `docs`: 文档更新
- `style`: 代码格式调整（不影响功能）
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建/工具链相关

**示例：**
```
feat(signal-control): add LLM-based traffic signal optimization

Implement a new module that uses large language models to optimize
traffic signal timing based on real-time traffic conditions.

Closes #123
```

### 4. 推送代码

```bash
# 推送到你的fork仓库
git push origin feature/your-feature-name
```

### 5. 创建 Pull Request

1. 访问GitHub仓库页面
2. 点击 "Pull Request" → "New Pull Request"
3. 选择你的分支
4. 填写PR描述：
   - 简要说明改动内容
   - 相关Issue编号
   - 测试情况
   - 截图（如有UI变化）

### 6. Code Review

- 团队成员会审查你的代码
- 根据反馈进行修改
- 通过审查后合并到主分支

---

## 📝 代码规范

### Python 代码风格

遵循 [PEP 8](https://www.python.org/dev/peps/pep-0008/) 规范：

```python
# 使用4个空格缩进
def calculate_traffic_flow(volume, capacity):
    """
    计算交通流量等级
    
    Args:
        volume: 交通量
        capacity: 道路容量
        
    Returns:
        流量等级 (A-F)
    """
    ratio = volume / capacity
    
    if ratio < 0.6:
        return 'A'
    elif ratio < 0.7:
        return 'B'
    # ...
    
    return 'F'
```

**工具推荐：**
```bash
# 代码格式化
pip install black
black your_code.py

# 代码检查
pip install pylint
pylint your_code.py

# 类型检查
pip install mypy
mypy your_code.py
```

### JavaScript 代码风格（如有前端项目）

遵循 [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)

### C++ 代码风格（如有嵌入式项目）

遵循 [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)

---

## 🧪 测试要求

### 单元测试

所有新功能必须包含单元测试：

```python
# tests/test_traffic_flow.py
import pytest
from traffic.flow import calculate_traffic_flow

def test_calculate_traffic_flow():
    assert calculate_traffic_flow(100, 200) == 'A'
    assert calculate_traffic_flow(140, 200) == 'B'
    
def test_calculate_traffic_flow_edge_cases():
    assert calculate_traffic_flow(0, 200) == 'A'
    with pytest.raises(ZeroDivisionError):
        calculate_traffic_flow(100, 0)
```

### 运行测试

```bash
# 运行所有测试
pytest

# 运行特定测试
pytest tests/test_traffic_flow.py

# 查看覆盖率
pytest --cov=src tests/
```

---

## 📖 文档要求

### 代码文档

- 所有公开函数/类必须有docstring
- 复杂逻辑需要注释说明
- 使用类型提示（Python 3.5+）

```python
from typing import List, Tuple

def optimize_signal_timing(
    traffic_data: List[float],
    constraints: dict
) -> Tuple[List[int], float]:
    """
    优化交通信号配时
    
    Args:
        traffic_data: 各方向交通流量数据
        constraints: 约束条件字典
            - min_green: 最小绿灯时间
            - max_green: 最大绿灯时间
            - cycle_length: 周期时长
            
    Returns:
        (optimal_timing, objective_value): 
            最优配时方案和目标函数值
            
    Raises:
        ValueError: 当输入数据不合法时
        
    Example:
        >>> traffic_data = [100, 80, 60, 40]
        >>> constraints = {'min_green': 15, 'max_green': 60}
        >>> timing, value = optimize_signal_timing(traffic_data, constraints)
    """
    pass
```

### README 文档

每个子项目应包含完整的README：
- 项目简介
- 安装步骤
- 使用示例
- API文档链接
- 许可证信息

---

## 🐛 报告 Bug

### 提交 Issue

在GitHub上创建Issue时，请包含：

1. **Bug描述**: 清晰描述问题
2. **复现步骤**: 详细的复现步骤
3. **期望行为**: 期望的正确行为
4. **实际行为**: 实际发生的情况
5. **环境信息**: 
   - 操作系统
   - Python版本
   - 依赖包版本
6. **截图/日志**: 相关的错误信息

**模板：**
```markdown
## Bug描述
交通流量计算结果异常

## 复现步骤
1. 导入模块 `from traffic import flow`
2. 调用 `flow.calculate(data)`
3. 输入数据为 [...]

## 期望结果
应该返回流量等级'A'

## 实际结果
返回了'None'

## 环境
- OS: Windows 11
- Python: 3.9.7
- traffic-lib: 1.2.3

## 错误日志
```
TypeError: unsupported operand type(s) for /: 'list' and 'int'
```
```

---

## 💡 提出新功能

创建 Feature Request Issue：

1. **功能描述**: 清晰描述功能需求
2. **使用场景**: 为什么需要这个功能
3. **建议方案**: 如何实现（可选）
4. **替代方案**: 其他可能的实现方式

---

## ✅ Pull Request Checklist

提交PR前，确保：

- [ ] 代码遵循项目规范
- [ ] 通过所有现有测试
- [ ] 添加了新功能的测试
- [ ] 更新了相关文档
- [ ] Commit message符合规范
- [ ] 代码已经过自我审查
- [ ] 没有引入不必要的依赖

---

## 📜 许可证

通过贡献代码，你同意你的贡献将在与项目相同的许可证下发布。

---

## 📞 联系我们

如有任何问题，欢迎联系：

- 📧 **邮箱**: chenshi_edu@gmail.com
- 💬 **讨论**: GitHub Discussions（待开启）
- 🐛 **Bug报告**: GitHub Issues

---

## 🙏 致谢

感谢所有为本项目做出贡献的开发者！

---

**最后更新**: 2026-07-08
