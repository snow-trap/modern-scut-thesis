#import "../lib.typ": documentclass

// SCUT 学位论文模板
// 字体可在系统安装 SimSun, SimHei, KaiTi, FangSong, Times New Roman, Arial

#let (
  // 布局函数
  doc, preface, mainmatter, appendix,
  // 页面函数
  fonts-display-page, cover, decl-page, abstract, abstract-en, bilingual-bibliography,
  outline-page, list-of-figures, list-of-tables, notation, acknowledgement, publications,
) = documentclass(
  doctype: "master",  // "master" | "doctor"
  twoside: true,      // 双面模式
  // anonymous: true, // 盲审模式
  info: (
    title: ("基于 Typst 的", "华南理工大学学位论文"),
    title-en: "SCUT Thesis Template for Typst",
    author: "张三",
    author-en: "Zhang San",
    student-id: "1234567890",
    department: "某学院",
    department-en: "XX School",
    major: "某专业",
    major-en: "XX Major",
    field: "某方向",
    field-en: "XX Field",
    supervisor: ("李四", "教授"),
    supervisor-en: "Prof. Li Si",
    submit-date: datetime.today(),
    defend-date: datetime.today(),
    confer-date: datetime.today(),
    school-code: "10561",
    clc: "TP391",
    udc: "004.9",
    secret-level: "公开",
    chairman: "某某某 教授",
    reviewer: ("某某某 教授", "某某某 教授"),
  ),
  // 参考文献源
  bibliography: bibliography.with("ref.bib"),
)

// 文稿设置
#show: doc

// 字体展示测试页（调试用，正式请注释）
// #fonts-display-page()

// 封面（含中文封面、英文内封、提名页）
#cover()

// 原创性声明和使用授权书
#decl-page()

// 前言（罗马数字页码）
#show: preface

// 中文摘要
#abstract(
  keywords: ("关键词一", "关键词二", "关键词三", "关键词四")
)[
  这里是中文摘要的内容。摘要应体现论文工作的核心思想，力求语言精练准确。

  摘要内容应涉及本项科研工作的目的和意义、研究思想和方法、研究成果和结论。

  硕士学位论文中文摘要一般约500～800字。博士学位论文中文摘要一般约1000字。
]

// 英文摘要
#abstract-en(
  keywords: ("Keyword1", "Keyword2", "Keyword3", "Keyword4")
)[
  Here is the English abstract content. The English abstract should be consistent with the Chinese abstract, conforming to English grammar with fluent expression.
]

// 目录
#outline-page()

// 图表清单（必要时启用）
// #list-of-figures()
// #list-of-tables()

// 正文
#show: mainmatter

// 符号表（必要时启用）
// #notation[
//   / SCUT: 华南理工大学 (South China University of Technology)
//   / Typst: 一种现代化的排版系统
// ]

= 绪　论

== 研究背景

正文内容。这是小四号宋体，1.5倍行距。正文段落首行缩进两个字。

== 国内外研究现状

正文内容。引用参考文献如 @蒋有绪1998，标注格式为[序号]。

= 正　文

== 理论分析

=== 基本概念

正文内容。

=== 核心算法

正文内容。

== 实验验证

=== 实验设计

正文内容。可以插入表格如 @tbl:example 和图片如 @fig:example。

#figure(
  table(
    align: center + horizon,
    columns: 3,
    [参数], [数值], [单位],
    table.hline(),
    [温度], [25], [℃],
    [压力], [101.3], [kPa],
    [时间], [60], [s],
  ),
  caption: [示例表格],
) <tbl:example>

#figure(
  rect(width: 60%, height: 80pt, fill: gray.lighten(30%)),
  caption: [示例图片],
) <fig:example>

== 结果分析

正文内容。引用的公式如式(1-1)：

$ y = a x + b $ <eqt:linear>

= 结　论

结论部分。结论作为单独一章排写，不加章号。结论应明确指出研究内容的创造性成果或创新性理论。

#bilingual-bibliography(full: true)

// 附录
#show: appendix

= 附录一

== 附录子标题

附录内容。

// 攻读学位期间取得的研究成果
#publications[
  此处可填写专利、著作、获奖项目等详细内容。
]

// 致谢
#acknowledgement[
  致谢内容。感谢指导教师和在学术方面对论文的完成有直接贡献及重要帮助的团体和人士。
]
