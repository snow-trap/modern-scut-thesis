// SCUT 英文摘要页
#import "../utils/style.typ": 字号, 字体, 正文字体, 正文字号, 正文行距, 正文段间距, 首行缩进, 节三级标题字号
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
  // 英文摘要与中文摘要同字号、同行距，引用共享常量
  leading: 正文行距,
  spacing: 正文段间距,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  [
    #set text(font: 正文字体, size: 正文字号)
    #set par(leading: leading, justify: true, spacing: spacing)

    // 不可见标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    // ABSTRACT 标题（SCUT规范：英文用 Times New Roman，小四号）
    #align(center)[
      #set text(font: "Times New Roman", size: 节三级标题字号, weight: "bold")
      #v(1em)
      ABSTRACT
    ]

    #v(1em)

    #set par(first-line-indent: 首行缩进)
    #body

    #v(1em)

    #set par(first-line-indent: 0pt)
    #text(weight: "bold")[Keywords: ]#(("",)+ keywords.intersperse("; ")).sum()
  ]
}
