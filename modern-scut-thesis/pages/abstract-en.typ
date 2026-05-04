// SCUT 英文摘要页
#import "../utils/custom-cuti.typ": fakebold
#import "../utils/style.typ": 字号, 字体
#import "../utils/invisible-heading.typ": invisible-heading

#let abstract-en(
  // documentclass 传入的参数
  doctype: "master",
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  keywords: (),
  outline-title: "ABSTRACT",
  outlined: true,
  // SCUT: 英文摘要与中文摘要同字号，1.5倍行距
  leading: 0.5em,
  spacing: 0pt,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  [
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(leading: leading, justify: true, spacing: spacing)

    // 不可见标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    // ABSTRACT 标题
    #align(center)[
      #set text(font: fonts.黑体, size: 字号.小二, weight: "bold")
      #v(1em)
      ABSTRACT
    ]

    #v(1em)

    #set par(first-line-indent: (amount: 2em, all: true))
    #body

    #v(1em)

    #fakebold[Keywords: ]#(("",)+ keywords.intersperse("; ")).sum()
  ]
}
