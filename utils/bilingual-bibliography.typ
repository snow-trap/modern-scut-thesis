// 中英双语参考文献：英文条目的“等”显示为“et al.”
//
// 原理：Typst 的 CSL 引擎（hayagriva）只支持单一全局语言环境（由 text.lang 决定），
// 无法像 citeproc-js 那样按条目语言切换。这里隐藏地以英文环境额外渲染一遍文献列表，
// 按网格行号收集各条目的英文版内容，再替换可见中文渲染中对应条目的整格内容。
// 中英文渲染均出自引擎自身，除中文条目判定正则（借自 modern-nju-thesis）外无硬编码替换。
//
// 已知限制：
// - 依赖顺序编码制文献列表的网格结构（序号列 x=0，内容列 x=1）；
//   换用不产生网格的 CSL 样式时静默回退为原始中文环境渲染。
// - 隐藏渲染会多占用一次文献列表的布局时间。

#let _en-cells = state("bilingual-bibliography-en-cells", (:))

#let _to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(_to-string).join("")
  } else if content.has("child") {
    _to-string(content.child)
  } else if content.has("body") {
    _to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

// 去除文献列表特征字后仍含两个以上连续汉字，判定为中文条目
#let _is-chinese(text) = {
  let pure = text.replace(regex("[等卷册和版本章期页篇译间者(不详)]"), "")
  pure.find(regex("\p{sc=Hani}{2,}")) != none
}

#let bilingual-bibliography(
  bibliography: none,
  title: "参考文献",
  full: false,
) = {
  assert(bibliography != none, message: "请传入带有 source 的 bibliography 函数。")

  [
    #show grid.cell.where(x: 1): it => {
      if _is-chinese(_to-string(it)) {
        it
      } else {
        context _en-cells.final().at(str(it.y), default: it)
      }
    }
    #bibliography(title: title, full: full)
  ]

  hide(box(height: 0pt, clip: true)[
    #set text(lang: "en")
    #show grid.cell.where(x: 1): it => {
      _en-cells.update(d => {
        d.insert(str(it.y), it)
        d
      })
      it
    }
    #bibliography(title: none, full: full)
  ])
}
