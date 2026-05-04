# TODO.md - SCUT Thesis Typst 模板重构计划

> 决策确认: 通用字体名 | 学术型硕/博 | 包含封面 | 复用bilingual-bibliography | 详细研究成果表格
> 状态: ✅ 全部完成，编译通过

## 阶段 1: 基础结构搭建 ✅
- [x] 1.1 创建 `typst.toml` 包配置
- [x] 1.2 创建 `utils/style.typ` 字体配置（SCUT 指定字体，无回退）
- [x] 1.3 创建 `utils/` 通用工具文件（custom-numbering, custom-heading, datetime-display, double-underline, hline, invisible-heading, justify-text, unpairs, custom-cuti, custom-tablex, bilingual-bibliography）
- [x] 1.4 创建 `lib.typ` 入口文件

## 阶段 2: 布局层 ✅
- [x] 2.1 创建 `layouts/doc.typ`（SCUT 25mm 页边距）
- [x] 2.2 创建 `layouts/preface.typ`（罗马数字页码）
- [x] 2.3 创建 `layouts/mainmatter.typ`（SCUT 标题字号/页眉/1.5pt 横线）
- [x] 2.4 创建 `layouts/appendix.typ`

## 阶段 3: 页面层 ✅
- [x] 3.1 创建 `pages/cover.typ`（中文封面+英文内封+提名页）
- [x] 3.2 创建 `pages/decl-page.typ`（原创性声明+版权授权书）
- [x] 3.3 创建 `pages/abstract.typ`（中文摘要）
- [x] 3.4 创建 `pages/abstract-en.typ`（英文摘要）
- [x] 3.5 创建 `pages/outline-page.typ`（目录）
- [x] 3.6 创建 `pages/list-of-figures.typ`（插图目录）
- [x] 3.7 创建 `pages/list-of-tables.typ`（表格目录）
- [x] 3.8 创建 `pages/notation.typ`（符号表）
- [x] 3.9 创建 `pages/acknowledgement.typ`（致谢）
- [x] 3.10 创建 `pages/publications.typ`（研究成果详细表格）
- [x] 3.11 创建 `pages/fonts-display-page.typ`（字体展示）

## 阶段 4: 模板与资源 ✅
- [x] 4.1 创建 `template/thesis.typ` 用户模板
- [x] 4.2 创建 `template/ref.bib` 示例参考文献

## 阶段 5: 编译测试 ✅
- [x] 5.1 `typst compile template/thesis.typ` 编译通过
- [x] 5.2 生成 output.pdf (280KB)
