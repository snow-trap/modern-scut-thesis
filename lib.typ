// 华南理工大学学位论文模板 modern-scut-thesis

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
#import "utils/custom-numbering.typ": custom-numbering
#import "utils/custom-heading.typ": heading-display, active-heading, current-heading
#import "utils/threeline-table.typ": threeline-table
#import "utils/theorem.typ": theorem, lemma, corollary, definition, proposition, example, remark, proof
#import "utils/algorithm.typ": algorithm-figure
#import "@preview/i-figured:0.2.4": show-figure, show-equation
#import "utils/style.typ": 字体, 字号

#let indent = h(2em)

// 全局配置工厂：聚合字体、信息、模式等参数，返回烘焙好配置的页面/布局闭包
#let documentclass(
  doctype: "master",
  twoside: false,
  anonymous: false,
  bibliography: none,
  fonts: (:),
  info: (:),
) = {
  fonts = 字体 + fonts

  return (
    doctype: doctype,
    twoside: twoside,
    anonymous: anonymous,
    fonts: fonts,
    info: info,

    doc: (..args) => {
      doc(..args, info: info + args.named().at("info", default: (:)))
    },
    preface: (..args) => {
      preface(twoside: twoside, ..args)
    },
    mainmatter: (..args) => {
      mainmatter(
        doctype: doctype, twoside: twoside, display-header: true,
        ..args, fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },
    appendix: (..args) => {
      appendix(reset-counter: true, ..args)
    },

    fonts-display-page: (..args) => {
      fonts-display-page(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    cover: (..args) => {
      cover(
        doctype: doctype, twoside: twoside, ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },
    decl-page: (..args) => {
      decl-page(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    abstract: (..args) => {
      abstract(
        doctype: doctype, twoside: twoside, ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },
    abstract-en: (..args) => {
      abstract-en(
        doctype: doctype, twoside: twoside, ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },
    outline-page: (..args) => {
      outline-page(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    list-of-figures: (..args) => {
      list-of-figures(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    list-of-tables: (..args) => {
      list-of-tables(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    notation: (..args) => {
      notation(twoside: twoside, ..args)
    },
    bibliography: bibliography,
    publications: (..args) => {
      publications(twoside: twoside, ..args, fonts: fonts + args.named().at("fonts", default: (:)))
    },
    acknowledgement: (..args) => {
      acknowledgement(twoside: twoside, ..args)
    },
    threeline-table: threeline-table,
    theorem: theorem,
    lemma: lemma,
    corollary: corollary,
    definition: definition,
    proposition: proposition,
    example: example,
    remark: remark,
    proof: proof,
    algorithm-figure: algorithm-figure,
  )
}
