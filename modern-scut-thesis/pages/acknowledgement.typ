// SCUT 致谢页
#let acknowledgement(
  twoside: false,
  title: "致　谢",
  outlined: true,
  body,
) = {
  pagebreak(weak: true, to: if twoside { "odd" })

  heading(level: 1, numbering: none, outlined: outlined, title)

  body
}
