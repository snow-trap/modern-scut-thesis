// 正文布局，配置 SCUT 规范的标题、页眉、行距等
#import "@preview/i-figured:0.2.4"
#import "../utils/style.typ": 字号, 字体, 正文字体, 正文字号, 正文行距, 正文段间距, 首行缩进, 辅助字体, 辅助字号, 章标题字体, 章标题字号, 节一级标题字号, 节二级标题字号, 节三级标题字号, 节标题字体
#import "../utils/custom-numbering.typ": custom-numbering
#import "../utils/custom-heading.typ": heading-display, active-heading, current-heading
#import "../utils/unpairs.typ": unpairs

#let mainmatter(
  // documentclass 传入参数
  doctype: "master",
  twoside: false,
  fonts: (:),
  // 其他参数
  leading: 正文行距,
  spacing: 正文段间距,
  justify: true,
  first-line-indent: 首行缩进,
  numbering: custom-numbering.with(first-level: "第一章 ", depth: 4, "1.1 "),
  // 正文字体与字号
  text-args: auto,
  // 标题字体与字号
  heading-font: auto,
  heading-size: auto,
  heading-weight: ("regular",),
  // SCUT: 标题段前段后各 0.5 行
  heading-above: auto,
  heading-below: auto,
  heading-pagebreak: (true, false),
  heading-align: auto,
  // 页眉
  header-render: auto,
  header-vspace: 0em,
  display-header: true,
  skip-on-first-level: false,
  stroke-width: 1.5pt,
  reset-footnote: true,
  // caption
  separator: "  ",
  caption-style: strong,
  caption-size: 辅助字号,
  // figure/equation 计数 (SCUT: 章-序号格式)
  show-figure: i-figured.show-figure.with(numbering: "1-1"),
  show-equation: i-figured.show-equation.with(numbering: "(1-1)"),
  ..args,
  it,
) = {
  set page(numbering: "1")

  fonts = 字体 + fonts
  if text-args == auto {
    text-args = (font: 正文字体, size: 正文字号)
  }
  if heading-font == auto {
    heading-font = (章标题字体, 节标题字体, 节标题字体, 节标题字体)
  }
  if heading-size == auto {
    heading-size = (章标题字号, 节一级标题字号, 节二级标题字号, 节三级标题字号)
  }
  if heading-above == auto {
    heading-above = (9pt, 7.5pt, 7pt, 6pt)
  }
  if heading-below == auto {
    heading-below = (9pt, 7.5pt, 7pt, 6pt)
  }
  if heading-align == auto {
    heading-align = (center, left, left, left)
  }

  let heading-text-args-lists = args.named().pairs()
    .filter((pair) => pair.at(0).starts-with("heading-"))
    .map((pair) => (pair.at(0).slice("heading-".len()), pair.at(1)))

  let array-at(arr, pos) = {
    arr.at(calc.min(pos, arr.len()) - 1)
  }

  // 基本样式
  set text(..text-args)
  show raw: set text(font: fonts.等宽)
  show footnote.entry: set text(font: 辅助字体, size: 辅助字号)

  // 图表编号与样式
  show heading: i-figured.reset-counters
  show figure: show-figure
  show math.equation.where(block: true): show-equation
  show figure.where(kind: table): set figure.caption(position: top)
  set figure.caption(separator: separator)
  show figure.caption: caption-style
  show figure.caption: set text(font: 辅助字体, size: 辅助字号)
  show terms: set par(first-line-indent: 0pt)

  // 标题编号
  set heading(numbering: numbering)

  // 标题样式 — 关键：用 v() 控制间距，不用 set block
  show heading: it => {
    set text(
      font: array-at(heading-font, it.level),
      size: array-at(heading-size, it.level),
      weight: array-at(heading-weight, it.level),
      ..unpairs(heading-text-args-lists
        .map((pair) => (pair.at(0), array-at(pair.at(1), it.level))))
    )
    if array-at(heading-pagebreak, it.level) {
      if "label" not in it.fields() or str(it.label) != "no-auto-pagebreak" {
        pagebreak(weak: true)
      }
    }
    v(array-at(heading-above, it.level), weak: true)
    if array-at(heading-align, it.level) != auto {
      align(array-at(heading-align, it.level), it)
    } else {
      it
    }
    v(array-at(heading-below, it.level), weak: true)
  }

  // 页眉与页脚
  let school-header = if doctype == "doctor" {
    "华南理工大学博士学位论文"
  } else {
    "华南理工大学硕士学位论文"
  }

  set page(
    margin: (x: 25mm, y: 25mm),
    footer: context {
      set text(font: 辅助字体, size: 辅助字号)
      align(center, counter(page).display("1"))
    },
    ..(if display-header {
      (
        header: context {
          if reset-footnote { counter(footnote).update(0) }
          let loc = here()
          let cur-heading = current-heading(level: 1)
          if not skip-on-first-level or cur-heading == none {
            if header-render == auto {
              set text(font: 辅助字体, size: 辅助字号)
              let header-text = if twoside and calc.rem(loc.page(), 2) == 0 {
                school-header
              } else {
                heading-display(active-heading(level: 1, prev: false))
              }
              align(center, stack(
                header-text,
                v(0.25em),
                line(length: 100%, stroke: stroke-width + black),
              ))
            } else {
              header-render(loc)
            }
            v(header-vspace)
          }
        }
      )
    } else {
      (header: {
        if reset-footnote { counter(footnote).update(0) }
      })
    }),
  )

  counter(page).update(1)

  // 段落样式
  set par(
    leading: leading,
    justify: justify,
    first-line-indent: first-line-indent,
    spacing: spacing,
  )

  it
}
