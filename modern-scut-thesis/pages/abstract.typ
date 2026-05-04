// SCUT 中文摘要页
#import "../utils/custom-cuti.typ": fakebold
#import "../utils/style.typ": 字号, 字体
#import "../utils/invisible-heading.typ": invisible-heading

#let abstract(
  // documentclass 传入的参数
  doctype: "master",
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  keywords: (),
  outline-title: "中文摘要",
  outlined: true,
  // SCUT: 摘要正文小四号宋体，1.5倍行距 (= 0.5em leading + 12pt font = 18pt baseline)
  leading: 0.5em,
  spacing: 0pt,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: "华南理工大学学位论文",
  ) + info

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  [
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(leading: leading, justify: true, spacing: spacing)

    // 不可见标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    // SCUT: "摘 要" 小二号黑体，居中
    #align(center)[
      #set text(font: fonts.黑体, size: 字号.小二, weight: "bold")
      #v(1em)
      摘　　要
    ]

    #v(1em)

    // SCUT: 摘要正文小四号宋体，1.5倍行距
    #set par(first-line-indent: (amount: 2em, all: true))
    #body

    #v(1em)

    // SCUT: 关键词，小四号黑体 + 小四号宋体
    #fakebold[关键词：]#(("",)+ keywords.intersperse("；")).sum()
  ]
}
