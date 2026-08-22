// 论文信息（单一真相源）
// 在这里统一维护作者、学号、学位类型、学院、专业、日期等信息。
// `template/thesis.typ` 会从本文件导入这些信息；封面、摘要等页面自动使用。

#let doctype = "master" // "master" | "doctor"

#let info = (
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
  school-name: "华南理工大学",
  school-name-en: "South China University of Technology",
  school-address-en: "Guangzhou, China",
  degree-type: "工学",
  // CLC 按学位类型自动选择：博士 TP391，硕士 TP273。
  // 如需固定值，改为具体分类号即可。
  clc: if doctype == "doctor" { "TP391" } else { "TP273" },
  udc: "004.9",
  secret-level: "公开",
  chairman: "某某某 教授",
  reviewer: ("某某某 教授", "某某某 教授", "某某某 教授"),
)