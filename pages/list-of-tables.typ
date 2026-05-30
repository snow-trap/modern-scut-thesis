// SCUT 表格目录
#import "@preview/i-figured:0.2.4"
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/style.typ": 字号, 字体, 章标题字体, 章标题字号

#let list-of-tables(
  twoside: false,
  fonts: (:),
  title: "表格目录",
  outlined: false,
  title-vspace: 18pt,
  title-text-args: auto,
  font: auto,
  size: 字号.小四,
  above: 14pt,
  below: 14pt,
  ..args,
) = {
  fonts = 字体 + fonts
  if title-text-args == auto {
    title-text-args = (font: 章标题字体, size: 章标题字号, weight: "bold")
  }
  if font == auto {
    font = fonts.宋体
  }

  pagebreak(weak: true, to: if twoside { "odd" })

  set text(font: font, size: size)

  {
    set align(center)
    text(..title-text-args, title)
    invisible-heading(level: 1, outlined: outlined, title)
  }

  v(title-vspace)

  show outline.entry: set block(
    above: above,
    below: below,
  )

  i-figured.outline(target-kind: table, title: none)

  if twoside {
    pagebreak() + " "
  }
}
