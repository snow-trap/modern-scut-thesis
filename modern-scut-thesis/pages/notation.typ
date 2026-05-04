// SCUT 符号表
#let notation(
  twoside: false,
  title: "符号表",
  outlined: true,
  width: 350pt,
  columns: (80pt, 1fr),
  row-gutter: 12pt,
  ..args,
  body,
) = {
  heading(
    level: 1,
    numbering: none,
    outlined: outlined,
    title
  )

  align(center, block(width: width,
    align(start, grid(
      columns: columns,
      row-gutter: row-gutter,
      ..args,
      ..body.children
        .filter(it => it.func() == terms.item)
        .map(it => (it.term, it.description))
        .flatten()
    ))
  ))

  if twoside {
    pagebreak() + " "
  }
}
