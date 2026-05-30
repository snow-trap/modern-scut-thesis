// SCUT 英文摘要
#import "../utils/style.typ": 字体, 正文字体, 正文字号, 正文行距, 正文段间距, 首行缩进, 章标题字号
#import "../utils/invisible-heading.typ": invisible-heading

#let abstract-en(
  doctype: "master",
  twoside: false,
  fonts: (:),
  info: (:),
  keywords: (),
  outline-title: "Abstract",
  outlined: true,
  leading: 正文行距,
  spacing: 正文段间距,
  body,
) = {
  fonts = 字体 + fonts

  pagebreak(weak: true, to: if twoside { "odd" })

  [
    #set text(font: 正文字体, size: 正文字号)
    #set par(leading: leading, justify: true, spacing: spacing)

    #invisible-heading(level: 1, outlined: outlined, outline-title)

    #align(center)[
      #set text(font: "Times New Roman", size: 章标题字号)
      #v(1em)
      Abstract
    ]

    #v(1em)

    #set par(first-line-indent: 首行缩进)
    #body

    #v(1em)

    #set par(first-line-indent: 0pt)
    #text(weight: "bold")[Keywords: ]#(("",)+ keywords.intersperse("; ")).sum()
  ]
}
