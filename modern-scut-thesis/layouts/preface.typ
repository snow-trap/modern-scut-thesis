// SCUT 前言：罗马数字页码
#import "../utils/style.typ": 字体, 辅助字体, 辅助字号

#let preface(
  twoside: false,
  fonts: (:),
  ..args,
  it,
) = {
  fonts = 字体 + fonts

  if twoside {
    pagebreak() + " "
  }
  counter(page).update(0)
  set page(
    numbering: "I",
    footer: context {
      set text(font: 辅助字体, size: 辅助字号)
      align(center, stack(
        counter(page).display("I"),
        v(15mm),
      ))
    },
  )
  it
}
