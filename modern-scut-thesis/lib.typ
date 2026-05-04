// 华南理工大学学位论文模板 modern-scut-thesis
// 基于 modern-nju-thesis 结构重构

#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/appendix.typ": appendix
#import "pages/fonts-display-page.typ": fonts-display-page
#import "pages/cover.typ": cover
#import "pages/decl-page.typ": decl-page
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "pages/outline-page.typ": outline-page
#import "pages/list-of-figures.typ": list-of-figures
#import "pages/list-of-tables.typ": list-of-tables
#import "pages/notation.typ": notation
#import "pages/acknowledgement.typ": acknowledgement
#import "pages/publications.typ": publications
#import "utils/custom-cuti.typ": *
#import "utils/bilingual-bibliography.typ": bilingual-bibliography
#import "utils/custom-numbering.typ": custom-numbering
#import "utils/custom-heading.typ": heading-display, active-heading, current-heading
#import "@preview/i-figured:0.2.4": show-figure, show-equation
#import "utils/style.typ": 字体, 字号

#let indent = h(2em)

// 使用函数闭包特性，通过 documentclass 函数进行全局信息配置
#let documentclass(
  doctype: "master",  // "master" | "doctor", 学位类型
  twoside: false,      // 双面模式，会加入空白页便于打印
  anonymous: false,    // 盲审模式
  bibliography: none,  // 原来的参考文献函数
  fonts: (:),          // 字体覆盖
  info: (:),           // 论文元信息
) = {
  // 默认参数
  fonts = 字体 + fonts
  info = (
    title: "华南理工大学学位论文",
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
    clc: "",
    udc: "",
    secret-level: "公开",
    chairman: "某某某 教授",
    reviewer: ("某某某 教授", "某某某 教授"),
  ) + info

  return (
    // 导出参数
    doctype: doctype,
    twoside: twoside,
    anonymous: anonymous,
    fonts: fonts,
    info: info,

    // 页面布局
    doc: (..args) => {
      doc(
        ..args,
        info: info + args.named().at("info", default: (:)),
      )
    },
    preface: (..args) => {
      preface(
        twoside: twoside,
        ..args,
      )
    },
    mainmatter: (..args) => {
      mainmatter(
        doctype: doctype,
        twoside: twoside,
        display-header: true,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },
    appendix: (..args) => {
      appendix(
        reset-counter: true,
        ..args,
      )
    },

    // 字体展示页
    fonts-display-page: (..args) => {
      fonts-display-page(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 封面（含中文封面、英文内封、提名页）
    cover: (..args) => {
      cover(
        doctype: doctype,
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },

    // 原创性声明和使用授权书
    decl-page: (..args) => {
      decl-page(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 中文摘要
    abstract: (..args) => {
      abstract(
        doctype: doctype,
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },

    // 英文摘要
    abstract-en: (..args) => {
      abstract-en(
        doctype: doctype,
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },

    // 目录
    outline-page: (..args) => {
      outline-page(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 插图目录
    list-of-figures: (..args) => {
      list-of-figures(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 表格目录
    list-of-tables: (..args) => {
      list-of-tables(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 符号表
    notation: (..args) => {
      notation(
        twoside: twoside,
        ..args,
      )
    },

    // 参考文献（双语处理）
    bilingual-bibliography: (..args) => {
      bilingual-bibliography(
        bibliography: bibliography,
        ..args,
      )
    },

    // 研究成果页
    publications: (..args) => {
      publications(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 致谢
    acknowledgement: (..args) => {
      acknowledgement(
        twoside: twoside,
        ..args,
      )
    },
  )
}
