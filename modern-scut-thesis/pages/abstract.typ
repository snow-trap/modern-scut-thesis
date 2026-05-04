// SCUT 中文摘要页
#import "../utils/style.typ": 字号, 字体, 正文字体, 正文字号, 正文行距, 正文段间距, 首行缩进, 章标题字体, 章标题字号
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
  // SCUT: 摘要正文引用共享常量（与matter一致）
  leading: 正文行距,
  spacing: 正文段间距,
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
    #set text(font: 正文字体, size: 正文字号)
    #set par(leading: leading, justify: true, spacing: spacing)

    // 不可见标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)

    // SCUT: "摘 要" 小二号黑体，居中
    #align(center)[
      #set text(font: 章标题字体, size: 章标题字号, weight: "bold")
      #v(1em)
      摘　　要
    ]

    #v(1em)

    // SCUT: 摘要正文，首行缩进
    #set par(first-line-indent: 首行缩进)
    #body

    #v(1em)

    // SCUT: 关键词标签用黑体（\abskeycn{\heiti\xiaosihao}），关键词正文用宋体，不缩进
    #set par(first-line-indent: 0pt)
    #text(font: fonts.黑体)[关键词：]#(("",)+ keywords.intersperse("；")).sum()
  ]
}
