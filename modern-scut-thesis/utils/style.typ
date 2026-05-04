// SCUT 学位论文字体与字号配置
// 参考 nju-thesis 结构，但仅保留 SCUT 指定字体，不设回退链

#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

// SCUT 学位论文规范字体：
// 宋体: SimSun, 数字和字母: Times New Roman
// 黑体: SimHei, 数字和字母: Arial
// 楷体: KaiTi, 数字和字母: Times New Roman
// 仿宋: FangSong, 数字和字母: Times New Roman
// 等宽: Courier New（拉丁）+ SimHei（中文）
#let 字体 = (
  宋体: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun"),
  黑体: ((name: "Arial", covers: "latin-in-cjk"), "SimHei"),
  楷体: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi"),
  仿宋: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong"),
  等宽: ((name: "Courier New", covers: "latin-in-cjk"), "SimHei"),
)
