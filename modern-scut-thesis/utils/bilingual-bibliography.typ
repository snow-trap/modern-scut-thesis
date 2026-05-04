// Authors: csimide, OrangeX4
// Tested only on GB-7714-2015-Numeric
#let bilingual-bibliography(
  bibliography: none,
  title: "参考文献",
  full: false,
  style: "gb-7714-2015-numeric",
  mapping: (:),
  extra-comma-before-et-al-trans: false,
  // 用于控制多位译者时表现为 `et al. tran`(false) 还是 `et al., tran`(true)
  allow-comma-in-name: false,
  // 如果使用的 CSL 中，英文姓名中会出现逗号，请设置为 true
) = {
  assert(bibliography != none, message: "请传入带有 source 的 bibliography 函数。")

  // Please fill in the remaining mapping table here
  mapping = (
    //"等": "et al",
    "卷": "Vol.",
    "册": "Bk.",
  ) + mapping

  let to-string(content) = {
    if content.has("text") {
      content.text
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("child") {
      to-string(content.child)
    } else if content.has("body") {
      to-string(content.body)
    } else if content == [ ] {
      " "
    }
  }

  show grid.cell.where(x: 1): it => {
    // 后续的操作是对 string 进行的。
    let ittext = to-string(it)
    // 判断是否为中文文献：去除特定词组后，仍有至少两个连续汉字。
    let pureittext = ittext.replace(regex("[等卷册和版本章期页篇译间者(不详)]"), "")
    if pureittext.find(regex("\p{sc=Hani}{2,}")) != none {
      // 新增功能：将带有"标准"两个字的一行中的 [Z] 替换为 [S]
      ittext = ittext.replace(
        regex("标准.*\[Z\]"),
        itt => {
          itt.text.replace(regex("\[Z\]"), "[S]")
        },
      )
      ittext
    } else {
      // 若不是中文文献，进行替换
      // 第xxx卷、第xxx册的情况：变为 Vol. XXX 或 Bk. XXX。
      let reptext = ittext
      reptext = reptext.replace(
        regex("(第\s?)?\d+\s?[卷册]"),
        itt => {
          if itt.text.contains("卷") {
            "Vol. "
          } else {
            "Bk. "
          }
          itt.text.find(regex("\d+"))
        },
      )

      // 第xxx版/第xxx本的情况：变为 1st ed 格式。
      reptext = reptext.replace(
        regex("(第\s?)?\d+\s?[版本]"),
        itt => {
          let num = itt.text.find(regex("\d+"))
          num
          if num.clusters().len() == 2 and num.clusters().first() == "1" {
            "th"
          } else {
            (
              "1": "st",
              "2": "nd",
              "3": "rd",
            ).at(num.clusters().last(), default: "th")
          }
          " ed"
        },
      )

      // 译者数量判断：单数时需要用 trans，复数时需要用 tran 。
      reptext = reptext.replace(regex("\].+?译"), itt => {
        let comma-in-itt = itt.text.replace(regex(",?\s?译"), "").matches(",")
        if (
          type(comma-in-itt) == array and 
          comma-in-itt.len() >= (
              if allow-comma-in-name {2} else {1}
            )
          ) {
          if extra-comma-before-et-al-trans {
            itt.text.replace(regex(",?\s?译"), ", tran")
          } else {
            itt.text.replace(regex(",?\s?译"), " tran")
          }
        } else {
          itt.text.replace(regex(",?\s?译"), ", trans")
        }
      })

      // `等` 特殊处理：`等`后方接内容也需要译作 `et al.`，如 `等译` 需要翻译为 `et al. trans`
      reptext = reptext.replace(
        regex("等."),
        itt => {
          "et al."
          // 如果原文就是 `等.`，则仅需简单替换，不需要额外处理
          // 如果原文 `等` 后没有跟随英文标点，则需要补充一个空格
          if not itt.text.last() in (".", ",", ";", ":", "[", "]", "/", "\\", "<", ">", "?", "(", ")", " ", "\"", "'") {
            " "
          }
          // 原文有英文句号时不需要重复句号，否则需要将匹配到的最后一个字符吐回来
          if not itt.text.last() == "." {
            itt.text.last()
          }
        },
      )

      // 其他情况：直接替换
      reptext = reptext.replace(
        regex("\p{sc=Hani}+"),
        itt => {
          mapping.at(itt.text, default: itt.text)
          // 注意：若替换功能工作良好，应该不会出现 `default` 情形
        },
      )
      reptext
    }
  }

  set text(lang: "zh")
  bibliography(
    title: title,
    full: full,
    style: style,
  )
}
