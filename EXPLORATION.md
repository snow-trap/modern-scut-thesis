# AGENTS.md - SCUT Thesis Typst 模板重构探索文档

## 项目概述
将 SCUT（华南理工大学）学位论文模板重构为类似 nju-thesis 的 Typst 模板。
- **源模板 (参考结构)**: `thirdparty/modern-nju-thesis` — Typst 编写的南京大学学位论文模板
- **SCUT 规范**: `modern-scut-thesis/rules/华南理工大学研究生学位论文撰写规范（2022年11月修订）.md`
- **SCUT LaTeX 原模板**: `thirdparty/SCUT_thesis` — 原 LaTeX 模板（参考格式要求）
- **目标目录**: `modern-scut-thesis` — 在此创建 Typst 模板

## 代码库结构

### modern-nju-thesis 代码结构（目标结构）
```
modern-nju-thesis/
├── lib.typ                          # 入口，定义 documentclass 函数
├── typst.toml                       # 包配置
├── layouts/
│   ├── doc.typ                      # 全局文档设置（页面边距、文本样式、PDF元信息、引用修复）
│   ├── preface.typ                  # 前言（重置页码为罗马数字）
│   ├── mainmatter.typ               # 正文（标题样式、页眉、脚注、图表编号、公式编号）
│   └── appendix.typ                 # 附录（重置标题编号格式）
├── pages/
│   ├── fonts-display-page.typ       # 字体展示测试页
│   ├── bachelor-cover.typ           # 本科生封面
│   ├── master-cover.typ             # 研究生封面（含中英文封面、提名页）
│   ├── bachelor-decl-page.typ       # 本科生声明页
│   ├── master-decl-page.typ         # 研究生声明页
│   ├── bachelor-abstract.typ        # 本科生中文摘要
│   ├── master-abstract.typ          # 研究生中文摘要
│   ├── bachelor-abstract-en.typ     # 本科生英文摘要
│   ├── master-abstract-en.typ       # 研究生英文摘要
│   ├── bachelor-outline-page.typ    # 目录页
│   ├── list-of-figures.typ          # 插图目录
│   ├── list-of-tables.typ           # 表格目录
│   ├── notation.typ                 # 符号表
│   └── acknowledgement.typ          # 致谢
├── utils/
│   ├── style.typ                    # 字体配置（字号映射表、字体族列表含回退）
│   ├── custom-numbering.typ         # 自定义标题编号
│   ├── custom-heading.typ           # 标题显示辅助（heading-display, active-heading, current-heading）
│   ├── custom-cuti.typ              # 导入 cuti 包（伪粗体）
│   ├── custom-tablex.typ            # 表格扩展
│   ├── bilingual-bibliography.typ   # 中英双语参考文献
│   ├── datetime-display.typ         # 日期显示（中英文）
│   ├── double-underline.typ         # 双下划线
│   ├── hline.typ                    # 水平线
│   ├── invisible-heading.typ        # 不可见标题（用于目录生成）
│   ├── justify-text.typ             # 文本两端对齐（用于表格中文 key）
│   └── unpairs.typ                  # pairs 数组转 dict
├── template/
│   ├── thesis.typ                   # 用户模板文件
│   ├── ref.bib                      # 示例参考文献
│   └── images/                      # 图片资源
├── fonts/                           # 字体文件（FangZheng, TimesNewRoman, Arial）
├── assets/vi/                       # SVG 矢量图资源
└── others/                          # 其他模板
```

### nju-thesis 字体管理机制（utils/style.typ）
使用字典 `字体` 定义五个字体族，每个字体族是一个数组，Typst 按顺序尝试使用：
```
字体 = (
  宋体: ((name: "Times New Roman", covers: "latin-in-cjk"), "Source Han Serif SC", "Source Han Serif", "Noto Serif CJK SC", "SimSun", "Songti SC", "STSongti"),
  黑体: ((name: "Arial", covers: "latin-in-cjk"), "Source Han Sans SC", ...),
  楷体: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi", "Kaiti SC", "STKaiti", "FZKai-Z03S"),
  仿宋: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong", "FangSong SC", "STFangSong", "FZFangSong-Z02S"),
  等宽: ((name: "Courier New", covers: "latin-in-cjk"), ...),
)
```
中文字号映射表 `字号`。

### nju-thesis documentclass 机制（lib.typ）
通过函数闭包实现全局配置：`documentclass()` 接收所有配置参数，返回拥有这些配置的具体布局/页面函数。

## SCUT 论文格式要求（关键差异）

### 字体要求（SCUT 指定，不需回退）
- 宋体: SimSun
- 黑体: SimHei  
- 楷体: KaiTi_GB2312 (或 KaiTi)
- 仿宋: FangSong_GB2312 (或 FangSong)
- 数字和字母: Times New Roman

### 标题字号
- 论文题目: 二号黑体，居中
- 各章标题: 小二号黑体，居中
- 各节一级标题: 小三号黑体，居左
- 各节二级标题: 四号黑体，居左
- 各节三级标题: 小四号黑体，居左
- 条、款、项标题: 小四号黑体，居左
- 正文: 小四号宋体
- 页眉: 五号宋体，居中
- 页码: 五号宋体，居中

### 页面设置
- 页边距: 上下左右各 25mm (≈94.5pt，nju 用的是 89pt)
- 正文: 1.5 倍行距，段前段后无空行
- 标题: 单倍行距，段前段后各 0.5 行

### 页眉
- 偶数页: "华南理工大学博士/硕士学位论文"
- 奇数页: 章序及章标题（如"第一章 绪论"）
- 页眉上边距 15mm，版心上边线加 1.5 磅实线

### 页码
- 主体部分→结束: 五号阿拉伯数字
- 摘要/目录等: 五号罗马数字
- 封面等: 不编入页码

### 论文结构（SCUT 特有）
1. 封面（中英文）
2. 英文内封
3. 提名页
4. 原创性声明和使用授权书
5. 中文摘要
6. 英文摘要
7. 目录
8. 图表清单及主要符号表（必要时）
9. 主体部分（绪论、正文、结论）
10. 参考文献
11. 附录
12. 攻读博士/硕士学位期间取得的研究成果
13. 致谢
14. 答辩委员会委员签名的答辩决议书（归档论文）
15. 定密审批表（涉密论文）

### SCUT vs NJU 关键差异
1. **学位层次**: SCUT 有博士、硕士（学术型/专业学位/同等学力）；NJU 有本科、硕士、博士
2. **封面**: SCUT 封面种类更多（学术型博士、专业学位博士、留学生、同等学力等），且有英文内封和提名页
3. **页眉**: SCUT 偶数页是学校+学位论文名称，奇数页是章标题；NJU 偶数页一级标题、奇数页二级标题
4. **标题编号**: SCUT 用"第一章"、"1.1"格式；NJU 也用类似格式
5. **原创性声明**: SCUT 有详细的声明和授权书格式
6. **研究成果页**: SCUT 需要列出攻读期间成果
7. **字体**: SCUT 指定 SimSun/SimHei/KaiTi_GB2312/FangSong_GB2312，不需要回退链

## 确认决策

| 问题 | 决策 |
|------|------|
| Q1 字体名称 | ✅ 使用通用字体名（SimSun, SimHei, KaiTi, FangSong） |
| Q2 封面类型 | ✅ 首次只做「学术型硕士」+「学术型博士」 |
| Q3 封面 | ✅ 需要包含封面（用于电子版/草稿） |
| Q4 参考文献 | ✅ 复用 nju 的 bilingual-bibliography 工具 |
| Q5 研究成果页 | ✅ 做详细表格模板 |

### 字体配置（最终方案）
```
字体 = (
  宋体: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun"),
  黑体: ((name: "Arial", covers: "latin-in-cjk"), "SimHei"),
  楷体: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi"),
  仿宋: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong"),
  等宽: ((name: "Courier New", covers: "latin-in-cjk"), "SimHei"),
)
```

---

## 重构计划要点
1. 复用 nju-thesis 的代码结构（目录组织、utils 工具函数）
2. 字体管理采用 nju-thesis 的 `style.typ` 模式，但去掉回退链，只保留 SCUT 指定的字体
3. 页面布局函数根据 SCUT 规范重写（封面、摘要、声明等）
4. mainmatter 布局根据 SCUT 规范调整（标题字号、页眉格式、行距）
5. 保留 nju-thesis 的通用工具函数（custom-numbering, custom-heading, datetime-display 等）

## 验证结果

### SCUT LaTeX cls vs Typst 关键配置对齐

| 配置项 | SCUT LaTeX cls | Typst (modern-scut-thesis) |
|--------|---------------|---------------------------|
| 页边距 | `left=2.5cm,right=2.5cm,bottom=2.5cm,top=2.5cm` | `margin: (x: 25mm, y: 25mm)` |
| 正文字号 | `\xiaosihao` (12pt 宋体) | `text-args: (font: 宋体, size: 字号.小四)` |
| 正文行距 | `\linespacing{1.682}` (~1.5倍) | `leading: 0.5em` (=1.5倍于12pt) |
| 段间距 | `\parskip{0ex}` | `spacing: 0pt` |
| 首行缩进 | 2字 | `first-line-indent: (amount: 2em)` |
| 章标题 | `\xiaoerhao\heiti\centering` (18pt居中) | `heading-size: 字号.小二, align: center` |
| 节一级标题 | `\xiaosanhao\heiti` (15pt居左) | `heading-size: 字号.小三, align: left` |
| 节二级标题 | `\sihao\heiti` (14pt居左) | `heading-size: 字号.四号, align: left` |
| 节三级标题 | `\xiaosihao\heiti` (12pt居左) | `heading-size: 字号.小四, align: left` |
| 标题段前段后 | 0.5行 (各层级不同) | `heading-above/below: (9pt,7.5pt,7pt,6pt)` |
| 页眉字体 | `\songti\wuhao` (10.5pt) | `font: 宋体, size: 字号.五号` |
| 页眉横线 | `\headrulewidth{1.5pt}` | `stroke: 1.5pt + black` |
| 页眉偶数页 | `华南理工大学博士/硕士学位论文` | `school-header` |
| 页眉奇数页 | `\leftmark` (章序及章标题) | `heading-display(active-heading(level: 1))` |
| 页脚页码 | `\songti\wuhao\thepage` (居中) | `字体.宋体, 字号.五号, align(center)` |
| 公式编号 | `\thechapter-\arabic{equation}` = (1-1) | `show-equation.with(numbering: "(1-1)")` |
| 图表编号 | `\thechapter-\arabic{figure}` = 图1-1 | `show-figure.with(numbering: "1-1")` |
| 参考文献格式 | GB/T 7714-2015 (biblatex) | `gb-7714-2015-numeric` + bilingual-bibliography |
| 参考文献字体 | `\songti\wuhao` | bibliography 默认处理 |
| 附录编号 | 独立不续主文章节号 | `reset-counter: true` |

### 使用 mineru 提取 PDF 闭环验证
- ✅ 中文封面、英文内封、提名页三页均正常生成
- ✅ 提名页文字不再断行，"华南理工大学"显示完整
- ✅ 原创性声明和版权授权书内容正确
- ✅ 中英文摘要格式正确，关键词格式正确
- ✅ 目录层级正确（章→节→条）
- ✅ 正文标题编号："第一章 绪论"、"1.1 研究背景"、"2.1.1 基本概念"
- ✅ 表格编号："表2-1" (章-序号格式)
- ✅ 图片编号："图2-1" (章-序号格式)
- ✅ 公式编号："(1-1)" (章-序号格式)
- ✅ 参考文献：[1] GB/T 7714-2015 格式正确
- ✅ 研究成果页：7列表格 + 其他成果区域
- ✅ 附录独立编号："附录一" + "1.1 附录子标题"
- ✅ 致谢页正常
