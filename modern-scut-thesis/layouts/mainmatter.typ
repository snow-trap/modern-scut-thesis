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
  leading: auto,       // 1.5倍行距，自动计算
  spacing: auto,       // 段前段后间距
  justify: true,
  first-line-indent: 首行缩进,
  numbering: custom-numbering.with(first-level: "第一章 ", depth: 4, "1.1 "),
  // 正文字体与字号参数
  text-args: auto,
  // 标题字体与字号
  // SCUT: 章标题小二号黑体居中, 一级小三黑体居左, 二级四号黑体居左, 三级小四黑体居左
  heading-font: auto,
  heading-size: auto,
  heading-weight: ("regular",),
  // SCUT: 章、节、条标题为单倍行距，段前段后各 0.5 行
  heading-above: auto,
  heading-below: auto,
  heading-pagebreak: (true, false),
  heading-align: auto,
  // 页眉
  // SCUT: 偶数页=学校+学位论文名称，奇数页=章序及章标题
  header-render: auto,
  header-vspace: 0em,
  display-header: true,
  // SCUT: 每页都要有页眉，不跳过章标题页（参考 fancypagestyle{plain}{\pagestyle{fancy}}）
  skip-on-first-level: false,
  // SCUT: 页眉下加 1.5 磅实线
  stroke-width: 1.5pt,
  reset-footnote: true,
  // caption 的 separator
  separator: "  ",
  // caption 样式
  caption-style: strong,
  caption-size: 字号.五号,
  // figure 计数 (SCUT: 图按章编排 "图 1-1")
  show-figure: i-figured.show-figure.with(numbering: "1-1"),
  // SCUT: 公式按章编排，第一章第一个公式为"(1-1)"
  show-equation: i-figured.show-equation.with(numbering: "(1-1)"),
  ..args,
  it,
) = {
  // 0.  标志前言结束
  set page(numbering: "1")

  // 1.  默认参数
  fonts = 字体 + fonts
  if text-args == auto {
    // SCUT: 正文小四号宋体
    text-args = (font: 正文字体, size: 正文字号)
  }
  // 1.1 SCUT 字体与字号
  if heading-font == auto {
    heading-font = (章标题字体, 节标题字体, 节标题字体, 节标题字体)
  }
  if heading-size == auto {
    // SCUT: 章小二号, 节一级小三号, 节二级四号, 节三级小四号
    heading-size = (章标题字号, 节一级标题字号, 节二级标题字号, 节三级标题字号)
  }
  if heading-above == auto {
    // SCUT: 标题段前段后各 0.5 行（单倍行距）
    // 0.5行按各层级字号计算: 小二=9pt, 小三=7.5pt, 四号=7pt, 小四=6pt
    heading-above = (9pt, 7.5pt, 7pt, 6pt)
  }
  if heading-below == auto {
    heading-below = (9pt, 7.5pt, 7pt, 6pt)
  }
  if heading-align == auto {
    // SCUT: 章居中, 其他居左
    heading-align = (center, left, left, left)
  }
  // 1.2 处理 heading- 开头的其他参数
  let heading-text-args-lists = args.named().pairs()
    .filter((pair) => pair.at(0).starts-with("heading-"))
    .map((pair) => (pair.at(0).slice("heading-".len()), pair.at(1)))

  // 2.  辅助函数
  let array-at(arr, pos) = {
    arr.at(calc.min(pos, arr.len()) - 1)
  }

  // 3.  设置基本样式
  // 3.1 文本和段落样式
  set text(..text-args)
  // SCUT: 正文 1.5 倍行距，段前段后无空行
  if leading == auto {
    // 正文1.5倍行距，引用共享常量
    set par(
      leading: 正文行距,
      justify: justify,
      first-line-indent: first-line-indent,
      spacing: 正文段间距,
    )
  } else {
    set par(
      leading: leading,
      justify: justify,
      first-line-indent: first-line-indent,
      spacing: spacing,
    )
  }
  show raw: set text(font: fonts.等宽)
  // 3.2 脚注样式
  show footnote.entry: set text(font: 辅助字体, size: 辅助字号)
  // 3.3 设置 figure 的编号
  show heading: i-figured.reset-counters
  show figure: show-figure
  // 3.4 设置 equation 的编号和假段落首行缩进
  show math.equation.where(block: true): show-equation
  // 3.5 表格表头置顶 + 不用冒号用空格分割 + 样式
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  set figure.caption(separator: separator)
  show figure.caption: caption-style
  show figure.caption: set text(font: 辅助字体, size: 辅助字号)
  // 3.6 优化列表显示
  show terms: set par(first-line-indent: 0pt)

  // 4.  处理标题
  // 4.1 设置标题的 Numbering
  set heading(numbering: numbering)
  // 4.2 设置字体字号并加入假段落模拟首行缩进
  show heading: it => {
    set text(
      font: array-at(heading-font, it.level),
      size: array-at(heading-size, it.level),
      weight: array-at(heading-weight, it.level),
      ..unpairs(heading-text-args-lists
        .map((pair) => (pair.at(0), array-at(pair.at(1), it.level))))
    )
    set block(
      above: array-at(heading-above, it.level),
      below: array-at(heading-below, it.level),
    )
    it
  }
  // 4.3 标题居中与自动换页
  show heading: it => {
    if array-at(heading-pagebreak, it.level) {
      // 如果打上了 no-auto-pagebreak 标签，则不自动换页
      if "label" not in it.fields() or str(it.label) != "no-auto-pagebreak" {
        pagebreak(weak: true)
      }
    }
    if array-at(heading-align, it.level) != auto {
      set align(array-at(heading-align, it.level))
      it
    } else {
      it
    }
  }

  // 5.  页眉与页脚合并设置
  // SCUT: 偶数页="华南理工大学博士/硕士学位论文"，奇数页=章序及章标题
  // 页眉五号宋体居中，下加 1.5 磅实线；页码五号宋体居中
  // (参考 scutthesis.tex: \fancyhead[CE]{学校名} \fancyhead[CO]{\leftmark}
  //                       \fancyfoot[C]{\thepage} \headrulewidth{1.5pt})
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
          // 重置 footnote 计数器
          if reset-footnote {
            counter(footnote).update(0)
          }
          let loc = here()
          let cur-heading = current-heading(level: 1)
          // 如果当前页面有一级标题且设置了跳过，则不渲染页眉
          if not skip-on-first-level or cur-heading == none {
            if header-render == auto {
              set text(font: 辅助字体, size: 辅助字号)
              // SCUT: 偶数页学校名，奇数页章标题
              let header-text = if twoside and calc.rem(loc.page(), 2) == 0 {
                school-header
              } else {
                heading-display(active-heading(level: 1, prev: false))
              }
              align(center, stack(
                header-text,
                v(0.25em),
                // 页眉下 1.5 磅实线
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
      (
        header: {
          if reset-footnote {
            counter(footnote).update(0)
          }
        }
      )
    }),
  )

  counter(page).update(1)

  it
}
