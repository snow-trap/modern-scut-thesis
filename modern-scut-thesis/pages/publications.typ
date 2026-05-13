// SCUT 研究成果
#import "../utils/style.typ": 字号, 字体, 章标题字体, 章标题字号, 辅助字体, 辅助字号

#let publications(
  twoside: false,
  fonts: (:),
  title: "攻读博士/硕士学位期间取得的研究成果",
  outlined: true,
  body,
) = {
  fonts = 字体 + fonts

  pagebreak(weak: true, to: if twoside { "odd" })

  align(center, text(
    font: 章标题字体,
    size: 章标题字号,
    weight: "bold",
    title,
  ))

  v(24pt)

  text(font: fonts.黑体, size: 字号.小四)[
    一、已发表（包括已接受待发表）的论文，以及已投稿、或已成文打算投稿、或拟成文投稿的论文情况（只填写与学位论文内容相关的部分）：
  ]

  v(12pt)

  set text(font: 辅助字体, size: 辅助字号)
  figure(
    table(
      align: center + horizon,
      columns: 7,
      table.header(
        [序号], [作者（全体作者，按顺序排列）], [题　目], [发表或投稿刊物名称、级别], [发表的卷期、年月、页码], [与学位论文哪一部分（章、节）相关], [被索引收录情况],
      ),
      table.hline(),
      [1], [], [], [], [], [], [],
      table.hline(),
      [2], [], [], [], [], [], [],
      table.hline(),
      [3], [], [], [], [], [], [],
      table.hline(),
      [4], [], [], [], [], [], [],
      table.hline(),
      [5], [], [], [], [], [], [],
    ),
  )

  v(8pt)

  text(font: fonts.宋体, size: 字号.五号)[
    注：在"发表的卷期、年月、页码"栏：\
    1 如果论文已发表，请填写发表的卷期、年月、页码；\
    2 如果论文已被接受，填写将要发表的卷期、年月；\
    3 以上都不是，请据实填写"已投稿"，"拟投稿"。\
    不够请另加页。
  ]

  v(16pt)

  text(font: fonts.黑体, size: 字号.小四)[
    二、与学位内容相关的其它成果（包括专利、著作、获奖项目等）
  ]

  v(12pt)

  body
}
