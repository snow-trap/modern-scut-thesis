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

// ===== 正文共享样式（摘要和正文统一引用，避免修改遗漏）=====
// SCUT 规范：正文小四号宋体，1.5倍行距，段前段后无空行，首行缩进2字
#let 正文字体 = 字体.宋体
#let 正文字号 = 字号.小四
#let 正文行距 = 1.4em // 经验值
#let 正文段间距 = 正文行距                  // 段间距同行距
#let 正文缩进 = 2em        // 首行缩进2字
#let 首行缩进 = (amount: 正文缩进, all: true)

// ===== 辅助样式：页眉/页脚/脚注/图表标题 =====
// SCUT 规范：页眉五号宋体居中，页码五号宋体居中，脚注五号宋体
#let 辅助字体 = 字体.宋体
#let 辅助字号 = 字号.五号  // 10.5pt

// ===== 标题样式（SCUT 规范各级标题字体字号）=====
#let 章标题字体 = 字体.黑体
#let 章标题字号 = 字号.小二  // 小二号 18pt，居中
#let 节一级标题字号 = 字号.小三  // 小三号 15pt，居左
#let 节二级标题字号 = 字号.四号  // 四号 14pt，居左
#let 节三级标题字号 = 字号.小四  // 小四号 12pt，居左
#let 节标题字体 = 字体.黑体       // 所有节标题统一黑体
