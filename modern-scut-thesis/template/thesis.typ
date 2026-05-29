#import "../lib.typ": documentclass

// SCUT 学位论文模板
// 字体可在系统安装 SimSun, SimHei, KaiTi, FangSong, Times New Roman, Arial

#let (
  doc,
  preface,
  mainmatter,
  appendix,
  fonts-display-page,
  cover,
  decl-page,
  abstract,
  abstract-en,
  bibliography,
  outline-page,
  list-of-figures,
  list-of-tables,
  notation,
  acknowledgement,
  publications,
  threeline-table,
  theorem,
  lemma,
  corollary,
  definition,
  proposition,
  example,
  remark,
  proof,
) = documentclass(
  doctype: "master", // "master" | "doctor"
  twoside: true, // 双面模式
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
#abstract(
  keywords: ("关键词一", "关键词二", "关键词三", "关键词四"),
)[
  摘要是学位论文内容的简短陈述，应体现论文工作的核心思想。
  论文摘要应力求语言精练准确。摘要内容应涉及本项科研工作的目的和意义、
  研究思想和方法、研究成果和结论。
  硕士学位论文的中文摘要一般约 500～800 字，必须突出论文的新见解。

  关键词一般为 3～5 个，按词条的外延层次排列（外延大的排在前面）。
  关键词之间用分号分开，最后一个关键词后不打标点符号。
]

// 英文摘要
#abstract-en(
  keywords: ("Keyword1", "Keyword2", "Keyword3", "Keyword4"),
)[
  The content of the English abstract and keywords should be consistent with the Chinese abstract and keywords, conform to English grammar, and be smooth and fluent in wording.
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

（此处填写基本概念和理论阐述。定理、引理、证明等环境的编写方法见第三章。）

=== 核心算法

（此处填写算法描述。算法伪代码编写方法见第三章。）

== 图表与公式

每个图均应有图题，图号按章编排，图题置于图下。

表序按章编排，表序与表名之间空一格，表名中不允许使用标点符号，表名后不加标点。表序与表名置于表上。表格采用三线表格式：顶线和底线为粗线，表头下线为细线，无竖线。

公式居中书写，序号按章编排。公式可以是独立编号的块级公式，也可以是前段文字的自然延续——前者公式后留空行另起段，后者则不加空行使后续文字视为同段延续。

图、表、公式的具体 Typst 写法见第三章。

== 实验验证

=== 实验设计

（此处填写实验设计方案。）

== 结果分析

（此处填写实验结果与分析。）

== 本章小结

论文正文各章后应有一节"本章小结"。

= 本模板说明

本章说明如何用本 Typst 模板实现 SCUT 规范中的各项格式。

== 章节标题

正文中 `=` 对应章标题，`==` 对应节标题，`===` 对应条标题。各层级自动按 SCUT 规范编号（如"第一章"、"1.1"、"1.1.1"）。结论章不加章号，在标题后加 `<no-numbering>` 标签即可。

== 定理环境

模板内置定理、引理、推论、定义、命题、例、备注、证明八种环境。
所有编号环境共享同一计数器，在每章起始处自动重置，序号格式为"章号-序号"。

#theorem[
  设 $p$ 为素数，$p ∤ a$，则 $a^(p-1) ≡ 1 (mod p)$。
] <thm:fermat>

#lemma[
  若 $a ≡ b (mod m)$，$c ≡ d (mod m)$，则
  $a + c ≡ b + d (mod m)$。
]

#proof[
  由同余定义直接可得。
]

#corollary[
  同余关系对减法也成立。
]

#definition(title: [素数])[
  一个大于 $1$ 的自然数，如果除了 $1$ 和它自身外，
  不能被其他自然数整除，称为素数。
]

#proposition[
  若 $a$ 和 $b$ 互素，则存在整数 $x$、$y$ 使 $a x + b y = 1$。
]

#example[
  设 $n = 7$，$a = 3$。由于 $7$ 为素数且 $7 ∤ 3$，
  由费马小定理得 $3^6 ≡ 1 (mod 7)$。
]

#remark[
  素数有无穷多个，这是古希腊数学家欧几里得在《几何原本》中
  首次证明的经典结论。
]

引用定理用 `@thm:fermat`，渲染为"@thm:fermat"。

== 图表

=== 三线表

使用 `threeline-table()` 封装函数，传入 `header` 和 `data` 即可：

#figure(
  threeline-table(
    columns: 3,
    header: ([参数], [数值], [单位]),
    data: (
      [温度], [25], [℃],
      [压力], [101.3], [kPa],
      [时间], [60], [s],
    ),
  ),
  caption: [示例表格],
) <example-table>

如需普通表格（如附录中的成果表），直接用 `table()` 即可。

=== 图片

插图用 `figure` + `image` 或任意图形内容：

#figure(
  rect(width: 60%, height: 80pt, fill: gray.lighten(30%)),
  caption: [示例图片],
) <example-figure>

== 公式

=== 独立编号公式

直接写块级公式并加标签，`i-figured` 自动编号：

$ y = a x + b $ <linear>

引用用 `@eqt:linear`，渲染为@eqt:linear。

=== 段内续写 vs 另起新段

中文论文中，块级公式有时属于前段文字的延续，此时不应另起段落。
Typst 会把块级公式当作独立 block 断开段落，需手动处理。

*不另起段*——段末 `\ ` 换行 + `#box(width: 100%)` 包裹公式，后续无缩进：

#figure(
  ```typ
  考虑一元二次方程 $a x^2 + b x + c = 0$，其根由求根公式给出： \
  #box(width: 100%)[$ x = (-b ± sqrt(b^2 - 4 a c)) / (2 a) $]
  当判别式 $b^2 - 4 a c > 0$ 时方程有两个不等实根。
  ```,
  caption: [不另起段的源码],
)

考虑一元二次方程 $a x^2 + b x + c = 0$，其根由求根公式给出： \
#box(width: 100%)[$ x = (-b ± sqrt(b^2 - 4 a c)) / (2 a) $]
当判别式 $b^2 - 4 a c > 0$ 时方程有两个不等实根。

*另起新段*——公式后空行，后续有 2em 首行缩进：

#figure(
  ```typ
  考虑一元二次方程 $a x^2 + b x + c = 0$，其根由求根公式给出：

  $ x = (-b ± sqrt(b^2 - 4 a c)) / (2 a) $

  当判别式 $b^2 - 4 a c > 0$ 时方程有两个不等实根。
  此结论可推广至复数域。
  ```,
  caption: [另起新段的源码],
)

考虑一元二次方程 $a x^2 + b x + c = 0$，其根由求根公式给出：

$ x = (-b ± sqrt(b^2 - 4 a c)) / (2 a) $

当判别式 $b^2 - 4 a c > 0$ 时方程有两个不等实根。
此结论可推广至复数域。

== 标签与引用

图表标签不加前缀，由 `i-figured` 自动生成带前缀的内部标签。引用时加对应前缀：

- 表格 `@tbl:my-table`，如@tbl:example-table
- 图片 `@fig:my-figure`，如@fig:example-figure
- 公式 `@eqt:my-eq`，如@eqt:linear

引用参考文献用 `@citation-key`，标注为上标方括号，如文献 @蒋有绪1998 所述。

== 代码块

代码块支持语法高亮和行号。

#figure(
  ```py
  def hello():
      print("Hello, SCUT!")
  ```,
  caption: [代码块示例],
) <code-example>

== 其他说明

- 字体：宋体、黑体、楷体、仿宋需系统已安装，拉丁字符统一用 Times New Roman。
- 盲审模式：在 `documentclass()` 中设置 `anonymous: true`，将隐藏作者和导师信息。
- 双面打印：`twoside: true` 时偶数页页眉显示学校名称，奇数页显示章标题。
- 图表清单：必要时可启用 `#list-of-figures()` 和 `#list-of-tables()`。

= 结　论 <no-numbering>

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
