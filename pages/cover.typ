// SCUT 封面（中文封面 + 英文内封 + 提名页）
#import "../utils/datetime-display.typ": datetime-display, datetime-en-display
#import "../utils/justify-text.typ": justify-text
#import "../utils/style.typ": 字号, 字体

#let cover(
  doctype: "master",
  twoside: false,
  fonts: (:),
  info: (:),
  stroke-width: 0.5pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, bottom: 0.5pt),
  info-key-width: 86pt,
  info-column-gutter: 18pt,
  info-row-gutter: 12pt,
  defence-inset: (x: 0pt, bottom: 2pt),
  defence-key-width: 110pt,
  defence-column-gutter: 2pt,
  defence-row-gutter: 12pt,
  datetime-display: datetime-display,
  datetime-en-display: datetime-en-display,
) = {
  fonts = 字体 + fonts
  info = (
    title: "华南理工大学学位论文",
    title-en: "Thesis Title in English",
    author: "张三",
    author-en: "Zhang San",
    major: "某专业",
    major-en: "XX Major",
    supervisor: ("李四", "教授"),
    supervisor-en: "Prof. Li Si",
    department: "某学院",
    department-en: "XX School",
    submit-date: datetime.today(),
    defend-date: datetime.today(),
    confer-date: datetime.today(),
    school-code: "10561",
    clc: "",
    udc: "",
    secret-level: "公开",
    student-id: "1234567890",
    field: "某方向",
    chairman: "某某某 教授",
    reviewer: ("某某某 教授", "某某某 教授"),
  ) + info

  if type(info.title) == str {
    info.title = info.title.split("\n")
  }
  if type(info.title-en) == str {
    info.title-en = info.title-en.split("\n")
  }
  // 标题行/评阅人补空行，日期格式化
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  info.reviewer = info.reviewer + range(5 - info.reviewer.len()).map((it) => "　")
  if type(info.defend-date) == datetime {
    info.defend-date = datetime-display(info.defend-date)
  }
  if type(info.confer-date) == datetime {
    info.confer-date = datetime-display(info.confer-date)
  }

  let info-key(body, inset: info-inset) = {
    set text(font: fonts.楷体, size: 字号.三号, weight: "bold")
    rect(
      width: 100%,
      inset: inset,
      stroke: none,
      justify-text(with-tail: true, body)
    )
  }

  let info-value(key, body, inset: info-inset, no-stroke: false) = {
    set align(center)
    rect(
      width: 100%,
      inset: inset,
      stroke: if no-stroke { none } else { (bottom: stroke-width + black) },
      text(
        font: fonts.宋体,
        size: 字号.三号,
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let defence-key = info-key.with(inset: defence-inset)
  let defence-value = info-value.with(inset: defence-inset)

  let degree-name = if doctype == "doctor" { "博士学位论文" } else { "硕士学位论文" }
  let degree-name-en = if doctype == "doctor" { "Doctor of Philosophy" } else { "Master" }

  // ====== 中文封面 ======
  pagebreak(weak: true, to: if twoside { "odd" })
  set align(center)

  v(30pt)
  text(size: 28pt, font: fonts.黑体, spacing: 200%, weight: "bold")[华 南 理 工 大 学]
  v(8pt)
  text(size: 18pt, font: fonts.宋体)[South China University of Technology]
  v(42pt)
  text(size: 字号.二号, font: fonts.黑体, weight: "bold", degree-name)
  v(42pt)

  block(width: 320pt, grid(
    columns: (info-key-width, 1fr),
    column-gutter: info-column-gutter,
    row-gutter: info-row-gutter,
    info-key("论文题目"),
    ..info.title.map((s) => info-value("title", s)).intersperse(info-key("　")),
    info-key("作者姓名"),
    info-value("author", info.author),
    info-key("学科专业"),
    info-value("major", info.major),
    info-key("指导教师"),
    info-value("supervisor", info.supervisor.intersperse(" ").sum()),
    info-key("所在学院"),
    info-value("department", info.department),
    info-key("论文提交日期"),
    info-value("submit-date", datetime-display(info.submit-date), no-stroke: true),
  ))

  // ====== 英文内封 ======
  pagebreak(weak: true)
  set text(font: fonts.宋体, size: 字号.小四)
  set par(leading: 1.5em)
  set align(center)

  v(50pt)
  text(font: "Times New Roman", size: 字号.二号, weight: "bold", info.title-en.intersperse("\n").sum())
  v(36pt)
  text(size: 字号.四号)[A Dissertation Submitted for the Degree of #degree-name-en]
  v(24pt)
  text(size: 字号.四号)[Candidate：]
  text(font: "Times New Roman", size: 字号.四号, weight: "bold", info.author-en)
  v(8pt)
  text(size: 字号.四号)[Supervisor：]
  text(font: "Times New Roman", size: 字号.四号, info.supervisor-en)
  v(36pt)
  text(size: 字号.四号, info.department-en)
  v(6pt)
  text(size: 字号.四号)[South China University of Technology]
  v(6pt)
  text(size: 字号.四号)[Guangzhou, China]
  v(24pt)
  datetime-en-display(info.submit-date)

  // ====== 提名页 ======
  pagebreak(weak: true)
  set align(left)
  set text(font: fonts.宋体, size: 字号.小四)

  grid(
    columns: (auto, 1fr, auto, 1fr, auto, 1fr),
    column-gutter: 8pt,
    row-gutter: 4pt,
    text(font: fonts.宋体, size: 字号.小四, "分类号："), text(font: fonts.宋体, size: 字号.小四, info.clc),
    text(font: fonts.宋体, size: 字号.小四, "学校代号："), text(font: fonts.宋体, size: 字号.小四, info.school-code),
    text(font: fonts.宋体, size: 字号.小四, "学　　号："), text(font: fonts.宋体, size: 字号.小四, info.student-id),
  )

  v(36pt)
  set align(center)
  text(font: fonts.黑体, size: 字号.小二, weight: "bold", "华南理工大学" + degree-name)
  v(12pt)
  text(font: fonts.黑体, size: 字号.四号, weight: "bold", info.title.intersperse("\n").sum())
  v(24pt)

  set align(left)
  set par(leading: 1.8em)

  [
    #set text(font: fonts.宋体, size: 字号.小四)
    作者姓名：#h(1em)#info.author
  ]
  [
    指导教师姓名、职称：#h(1em)#info.supervisor.intersperse(" ").sum()
  ]
  [
    申请学位级别：#h(1em)#(if doctype == "doctor" { "工学博士" } else { "工学硕士" })
  ]
  [
    学科专业名称：#h(1em)#info.major
  ]
  [
    研究方向：#h(1em)#info.field
  ]
  [
    论文提交日期：#h(1em)#datetime-display(info.submit-date)
  ]
  [
    论文答辩日期：#h(1em)#info.defend-date
  ]
  [
    学位授予单位：#h(1em)华南理工大学
  ]
  [
    学位授予日期：#h(1em)#info.confer-date
  ]

  v(16pt)
  text(font: fonts.宋体, size: 字号.小四, weight: "bold", "答辩委员会成员：")
  v(4pt)
  text(font: fonts.宋体, size: 字号.小四, "主席：　" + info.chairman)
  v(4pt)
  text(font: fonts.宋体, size: 字号.小四, "委员：　" + info.reviewer.intersperse("　").sum())
}
