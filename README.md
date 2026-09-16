# 华南理工大学学位论文 modern-scut-thesis

华南理工大学**硕士/博士学位论文**的 Typst 模板，能够简洁、快速、持续生成符合 SCUT 学位论文格式规范的 PDF。[Typst Universe](https://typst.app/universe/package/modern-scut-thesis)

## 劣势

- Typst 是一门新生的排版标记语言，还做不到像 Word 或 LaTeX 一样成熟稳定。
- 该模板是民间模板，**存在不被认可的风险**。

## 优势

Typst 是可用于出版的可编程标记语言，拥有变量、函数与包管理等现代编程语言的特性，定位与 LaTeX 相似。相对 LaTeX：

- **语法简洁**：上手难度与 Markdown 相当，文本源码可读性高，不会充斥着反斜杠与花括号。
- **编译速度快**：采用增量编译，文档长度基本不影响编译速度，配合编辑器插件可边写作边预览。
- **环境搭建简单**：不需要像 LaTeX 一样安装数 GB 的宏包体系，编译器是单一可执行文件，第三方包在首次引用时自动下载。

可以参考 [Typst 中文文档网站](https://typst-doc-cn.github.io/docs/) 迅速入门。

## 使用

需要 **Typst 0.15.0 或更新版本**。

模板已上传 Typst Universe。论文源文件只需修改 `thesis.typ` 与 `info.typ`，基本可以满足所有需求。

### 准备字体

默认论文排版使用宋体（SimSun）、黑体（SimHei）、Times New Roman，以及代码中的 Courier New，建议至少准备以下完整字形集：

```text
CourierNew-Regular.ttf
CourierNew-Bold.ttf
CourierNew-Italic.ttf
CourierNew-BoldItalic.ttf
TimesNewRoman-Regular.ttf
TimesNewRoman-Bold.ttf
TimesNewRoman-Italic.ttf
TimesNewRoman-BoldItalic.ttf
SimSun-Regular.ttf
SimHei-Regular.ttf
```

楷体和仿宋（可选）：

```text
KaiTi-Regular.ttf
FangSong-Regular.ttf
```


Windows 自带上述字体，开箱即用；macOS 通过字体册安装，Linux 可复制字体文件到 `~/.local/share/fonts` 后执行 `fc-cache -f`。安装完成后用 `typst fonts` 确认编译器能识别；在线编辑需在创建项目后把字体文件上传到项目目录。若成稿字体与预期不符，可临时启用 `#fonts-display-page()` 检查实际命中的字体。实在无法安装上述字体时，可在 `documentclass` 的 `fonts` 参数中覆盖字体配置（配置结构见 `utils/style.typ`）。

### VS Code 本地编辑（推荐）

1. 安装 Typst（如 `winget install --id Typst.Typst` / `brew install typst`，或见 [官方安装说明](https://github.com/typst/typst?tab=readme-ov-file#installation)）。
2. 在 VS Code 中安装 [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)。
3. 按下 `Ctrl + Shift + P`，输入 `Typst: Show available Typst templates (gallery)`，从中找到 `modern-scut-thesis`，点击 `+` 创建论文项目。
4. 打开生成的目录中的 `thesis.typ`，按下 `Ctrl + K V` 实时编辑和预览。

也可以用命令行初始化：

```sh
typst init @preview/modern-scut-thesis:0.1.0 my-thesis
cd my-thesis
typst compile thesis.typ
```

`typst init` 只复制论文源文件，模板实现由包仓库自动拉取。如需修改模板内部样式或使用构建脚本，请克隆[源码仓库](https://github.com/snow-trap/modern-scut-thesis)。

写作过程中建议用 Git 管理论文：`.typ` 源文件按章节粒度提交，便于回退、对比与协作；编译产物（PDF）写入 `.gitignore`，只跟踪源文件。

### 在线编辑

在 [Typst Web App](https://typst.app/?template=modern-scut-thesis&version=0.1.0) 的 `Start from template` 里选择 `modern-scut-thesis` 即可在线创建。

**注意：Web App 没有安装模板所需的中文字体，需按上文「准备字体」将字体文件上传到项目中，否则会导致文字空白或异常回退到别的字体。Web App 也不提供命令行构建参数，盲审、印刷等变体需直接修改项目根目录 `build.typ` 的默认值，查重版需改用本地 Typst CLI 完成。**

### 构建变体

除最终版外，模板支持盲审（单盲/双盲）、印刷、查重等构建变体，参数与命令见模板内第三章「构建变体」一节。[源码仓库](https://github.com/snow-trap/modern-scut-thesis)的 `scripts/` 目录另提供封装脚本（`build.sh` / `build.ps1`），支持 Windows 与 Linux/macOS；请注意，互联网上的脚本可能损坏您的电脑，即使你信任我，也请检查脚本内容后再执行！

## 特性

- **封面代码生成**：中文封面、英文内封与提名页均由模板排版生成，无需用 Word 制作封面再转换为 PDF
- **封面变体**：`kind: "professional"` 专业学位、`international: true` 留学生学位论文、`equivalent: true` 同等学力申请学位，再加上其盲审版本，34 种封面变体皆可用 typst 代码参数化生成
- **盲审模式**：`blind: "single" | "double"` 一键切换，除改变封面，也支持不输出英文内封与致谢，研究成果清单切换为匿名表格，PDF 元数据不写入作者
- **构建变体**：查重版自动抽取正文页范围并关闭 PDF 标签，印刷版自动为封面等前置页补充空白背面，无需手工拆分 PDF
- **定理环境**：内置定理、引理、推论、定义、命题、例、备注、证明八种环境，每章自动重置计数（基于 `great-theorems`）
- **图表公式**：图片/表格/公式按章编号（图 1-1、表 1-1、式 (1-1)），交叉引用使用 `@fig:`、`@tbl:`、`@eqt:` 前缀（编号基于 `i-figured`）
- **三线表**：`threeline-table()` 封装，传入 `header` 与 `data` 即可
- **算法伪代码**：`algorithm-figure()` 自动编号（基于 `algorithmic`）
- **代码块**：行号与语法高亮（基于 `zebraw`）
- **实验数据管理**：实验常量集中在 `data.typ` 定义，正文以变量引用，修改一处全文自动更新
- **参考文献**：BibTeX 条目与 GB/T 7714—2015 CSL 样式分离，样式随包分发且可一行覆盖；中文条目显示“等”、英文条目自动显示“et al.”

## 目录结构

```text
.
├── typst.toml            # 包配置
├── lib.typ               # 主入口，导出 documentclass()
├── template/             # typst init 复制的内容（用户论文起点）
│   ├── thesis.typ        # 论文源文件
│   ├── info.typ          # 论文信息（题目、作者、学号等）
│   ├── build.typ         # 构建参数（盲审、双面等开关）
│   ├── data.typ          # 实验数据常量（正文以变量引用）
│   ├── ref.bib           # 参考文献
│   └── images/           # 论文配图目录
├── assets/               # 模板自身资源（校徽等，包内使用）
├── layouts/              # 布局（doc/preface/mainmatter/appendix）
├── pages/                # 独立页面（封面、声明页、摘要、目录等）
├── utils/                # 辅助函数（字体字号、编号、定理环境等）
├── GB-T-7714—2015（….csl # 默认参考文献样式（包内引用，不复制进用户项目）
└── scripts/              # 构建脚本（build.sh / build.ps1，仅仓库提供）
```

- `utils` 目录：不渲染出页面的辅助函数
- `pages` 目录：会渲染出不影响其他页面的独立页面的函数
- `layouts` 目录：应用于 `show` 指令的、横跨多个页面的布局函数
- `lib.typ`：统一对外接口，通过 `documentclass` 函数闭包进行全局信息配置

## Q&A

### 为什么 PDF 中没有文字或显示为「豆腐块」？

本地没有安装对应字体。请参照上文「准备字体」一节的文件列表准备字体后重新编译；也可用 `#fonts-display-page()` 显示字体渲染测试页检查显示效果（该页额外需要楷体和仿宋）。字体名称可通过 `typst fonts` 查询。

### 我习惯了 LaTeX 公式语法，可以直接用吗？

Typst 的公式语法与 LaTeX 不同，直接粘贴 LaTeX 源码无法编译。可用 [mitex](https://typst.app/universe/package/mitex) 渲染 LaTeX 公式，或用 [tex2typst](https://github.com/qwinsi/tex2typst) 将存量公式转换为 Typst 语法。


## 参与贡献

- 在 Issues 中提出你的想法
- 欢迎提交 PR

## 致谢

- 感谢 [SCUT_thesis](https://github.com/mengchaoheng/SCUT_thesis) LaTeX 模板，它是本仓在论文规范上的第二标准，学校 2022 年规范未规定之处的实现决策多参考于它
- 感谢 [modern-nju-thesis](https://github.com/nju-lug/modern-nju-thesis)，本模板的代码架构参考了它
- 感谢 Typst 中文社区维护的 [小蓝书](https://typst-doc-cn.github.io/tutorial/) 与 [FAQ](https://typst-doc-cn.github.io/guide/)
- 感谢 [great-theorems](https://typst.app/universe/package/great-theorems)、[i-figured](https://typst.app/universe/package/i-figured)、[zebraw](https://typst.app/universe/package/zebraw)、[algorithmic](https://typst.app/universe/package/algorithmic)、[cuti](https://typst.app/universe/package/cuti) 等包的作者

## 许可

本模板的代码与文档基于 MIT License 开源（见 [LICENSE](LICENSE) 文件）。以下文件不适用 MIT 许可，其权利归各自权利人所有：

- `GB-T-7714—2015（顺序编码，双语，姓名不大写，无URL、DOI）.csl`：取自 [Zotero 中文社区样式库](https://zotero-chinese.com/styles/)，以 [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) 许可发布，版权归原作者（牛耕田等）所有，文件头部附有许可声明。
- 校徽与校名图片（`assets/scut-logo.jpg`、`template/images/scut_logo.jpg`）：版权归华南理工大学所有，官方版本见学校官网「[学校标识](https://www.scut.edu.cn/new/9017/list.htm)」页面。本模板仅为学位论文排版目的附带上述图片，不授予任何其他使用权利。
