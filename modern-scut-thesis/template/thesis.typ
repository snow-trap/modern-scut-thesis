#import "../lib.typ": documentclass

// SCUT 学位论文模板
// 字体可在系统安装 SimSun, SimHei, KaiTi, FangSong, Times New Roman, Arial

#let (
  doc, preface, mainmatter, appendix,
  fonts-display-page, cover, decl-page, abstract, abstract-en, bibliography,
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
  bibliography: bibliography.with("ref.bib", style: "GB-T-7714—2015（顺序编码，双语，姓名不大写，无URL、DOI）.csl"),
)

// 全局页面设置
#show: doc

// 字体展示测试页（调试用）
// #fonts-display-page()

// 封面
#cover()

// 声明页
#decl-page()

// 前言：罗马数字页码
#show: preface

// 中文摘要
// “摘要是学位论文内容的简短陈述，应体现论文工作的核心思想。”
// “摘要内容应涉及本项科研工作的目的和意义、研究思想和方法、研究成果和结论。”
// “博士学位论文的中文摘要一般约1000字；硕士学位论文的中文摘要一般约500～800字。”
// “关键词一般为3～5个，按词条的外延层次排列（外延大的排在前面）。关键词之间用分号分开，最后一个关键词后不打标点符号。”
#abstract(
  keywords: ("关键词一", "关键词二", "关键词三", "关键词四")
)[
  这里是中文摘要的内容。
]

// 英文摘要
// “英文摘要的内容及关键词应与中文摘要及关键词一致，要符合英语语法，语句通顺，文字流畅。”
#abstract-en(
  keywords: ("Keyword1", "Keyword2", "Keyword3", "Keyword4")
)[
  Here is the English abstract content.
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

绪论（或引言）一般作为第一章，是论文主体的开端。绪论的内容应简要说明研究工作的目的、范围、相关领域的前人工作和知识空白、理论基础、研究设想、研究方法和实验设计、预期结果和意义等。应言简意赅，不要与摘要雷同，不要写成摘要的注释。一般教科书中有的知识，在绪论中不必赘述。

学位论文为了反映出作者确已掌握了坚实的基础理论和系统的专门知识，具有开阔的科学视野，对研究方案作了充分论证，因此，有关历史回顾和前人工作的综述分析，以及理论分析等，可以单独成章，用足够的文字叙述。

== 研究背景

== 国内外研究现状

引用参考文献时采用顺序编码制，标注格式为[序号]，如文献[1]所述。

= 正　文

论文正文是学位论文的核心部分，占主要篇幅。正文应该结构合理，层次分明，推理严密，重点突出，图表、参考文献规范，内容集中简练，文笔通顺流畅。博士学位论文不少于6万字，硕士学位论文为3～5万字。

对本研究内容及成果应进行较全面、客观的理论阐述，应着重指出本研究内容中的创新、改进与实际应用之处。理论分析中，应将他人研究成果单独书写，并注明出处，不得将其与本人提出的理论分析混淆在一起。

自然科学的论文应推理正确，结论清晰，无科学性错误。

== 理论分析

=== 基本概念

=== 核心算法

公式序号按章编排，如第一章第一个公式序号为"(1-1)"：

$ y = a x + b $ <eqt:linear>

== 实验验证

=== 实验设计

每个图均应有图题（由图号和图名组成）。图号按章编排，如第一章第一图的图号为"图1-1"等。图题置于图下。表序一般按章编排，如第一章第一个插表的序号为"表1-1"等。表序与表名之间应空一格，表名中不允许使用标点符号，表名后不加标点。表序与表名置于表上。

示例表格如表 @tbl:example，示例图片如图 @fig:example。

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

== 本章小结

论文正文各章后应有一节"本章小结"。

= 结　论

学位论文的结论单独作为一章排写，但不加章号。

结论是对整个论文主要成果的总结。在结论中应明确指出本研究内容的创造性成果或创新性理论（含新见解、新观点），对其应用前景和社会、经济价值等加以预测和评价，并指出今后进一步在本研究方向进行研究工作的展望与设想。

如果不能导出应有的结论，也可以没有结论而进行必要的讨论。

#bibliography(title: "参考文献", full: true)

// 附录
// “对需要收录于学位论文中但又不适合书写于正文中的附加数据、方案、资料、详细公式推导、计算机程序、统计表、注释等有特色的内容，可做为附录排写，序号采用‘附录1’、‘附录2’等。”
#show: appendix

= 附录一

== 附录子标题

附录内容。

// 攻读学位期间取得的研究成果
// “攻读博士/硕士学位期间取得的研究成果一般包括发表（含录用、已投稿、拟投稿）的与学位论文相关的学术论文、发明专利、著作、获奖科研项目等。”
#publications[
  此处可填写专利、著作、获奖项目等详细内容。
]

// 致谢
// “致谢中主要感谢指导教师和在学术方面对论文的完成有直接贡献及重要帮助的团体和人士，以及感谢给予转载和引用权的资料、图片、文献、研究思想和设想的所有者。致谢辞应谦虚诚恳，内容简洁明了、实事求是。”
#acknowledgement[
  致谢内容。感谢指导教师和在学术方面对论文的完成有直接贡献及重要帮助的团体和人士。
]
