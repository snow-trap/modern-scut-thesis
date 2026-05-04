// SCUT 原创性声明和使用授权书
#import "../utils/style.typ": 字号, 字体

#let decl-page(
  twoside: false,
  fonts: (:),
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  // ====== 原创性声明 ======
  v(25pt)

  align(
    center,
    text(
      font: fonts.黑体,
      size: 字号.四号,
      weight: "bold",
      "华南理工大学学位论文原创性声明",
    ),
  )

  v(36pt)

  block[
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 0.8em)

    本人郑重声明：所呈交的论文是本人在导师的指导下独立进行研究所取得的研究成果。除了文中特别加以标注引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写的成果作品。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律后果由本人承担。
  ]

  v(56pt)

  align(right)[
    #set text(font: fonts.宋体, size: 字号.小四)
    
    作者签名：#h(5em) \ 
    日　　期：#h(5em)
  ]

  // ====== 版权使用授权书 ======
  v(20pt)

  align(
    center,
    text(
      font: fonts.黑体,
      size: 字号.四号,
      weight: "bold",
      "学位论文版权使用授权书",
    ),
  )

  v(36pt)

  block[
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 0.8em)

    本学位论文作者完全了解学校有关保留、使用学位论文的规定，即：研究生在校攻读学位期间论文工作的知识产权单位属华南理工大学。学校有权保存并向国家有关部门或机构送交论文的复印件和电子版，允许学位论文被查阅（除在保密期内的保密论文外）；学校可以公布学位论文的全部或部分内容，可以允许采用影印、缩印或其它复制手段保存、汇编学位论文。本人电子文档的内容和纸质论文的内容相一致。

    本学位论文属于：

    □ 保密（校保密委员会审定为涉密学位论文时间：　　年　　月　　日），于　　年　　月　　日解密后适用本授权书。

    □ 不保密，同意在校园网上发布，供校内师生和与学校有共享协议的单位浏览；同意将本人学位论文编入有关数据库进行检索，传播学位论文的全部或部分内容。

    （请在以上相应方框内打"√"）
  ]

  v(40pt)

  align(right)[
    #set text(font: fonts.宋体, size: 字号.小四)
    
    作者签名：#h(5em) \ 
    日　　期：#h(5em)
  ]

  v(16pt)

  align(right)[
    #set text(font: fonts.宋体, size: 字号.小四)
    
    指导教师签名：#h(5em) \ 
    日　　期：#h(5em)
  ]

  v(16pt)

  [
    #set text(font: fonts.宋体, size: 字号.小四)
    作者联系电话： \ 
    电子邮箱： \ 
    联系地址（含邮编）：
  ]
}
