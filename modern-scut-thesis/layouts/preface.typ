// 前言，重置页面计数器，使用罗马数字页码
// SCUT: 摘要、目录等前置部分用五号罗马数字，居中
#import "../utils/style.typ": 字号, 字体

#let preface(
  // documentclass 传入参数
  twoside: false,
  fonts: (:),
  ..args,
  it,
) = {
  fonts = 字体 + fonts
  // 分页
  if twoside {
    pagebreak() + " "
  }
  counter(page).update(0)
  // SCUT: 五号罗马数字，页脚居中
  set page(
    numbering: "I",
    footer: context {
      set text(font: fonts.宋体, size: 字号.五号)
      align(center, counter(page).display("I"))
    },
  )
  it
}
