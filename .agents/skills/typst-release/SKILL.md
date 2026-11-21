---
name: typst-release
description: 把 modern-scut-thesis 的新版本发布到 typst/packages（Typst Universe）：改版本号、导出包内容、开 PR、合并后打标签。用户说「发版 / 发布 / 提 PR 更新包版本 / 打 release tag」时加载。
---

# 发布新版本到 Typst Universe

`<版本>` 形如 `0.1.2`，`<fork>` 默认 `~/PRJ/packages`（typst/packages 的 sparse + partial 克隆）。

## 不变量

- 已发布的版本目录永久不可改，改动只能发新版本号
- 包内容 = 已跟踪文件 − `.gitattributes` 里 `export-ignore` 的路径（当前 `/scripts/`、`/CONTRIBUTING.md`、`/.agents/`）
- `git archive` 只导出**已提交**内容：先提交再导出，规则改动也必须先提交
- `typst.toml` 的 `exclude = ["/docs/"]`：docs 图提交进 packages 供 README 引用，但不进用户下载的 bundle
- 非用户要求永不推送

## 1. 改版本号并提交

四处同步，`typst.toml` 是唯一来源：

- `typst.toml` 的 `version`
- `template/thesis.typ` 的 `@preview/modern-scut-thesis:<版本>`
- `README.md` 的 `typst init @preview/...:<版本>`
- `README.md` 的 Web App 链接 `&version=<版本>`

```sh
rg -n 'modern-scut-thesis:|&version=|^version' typst.toml README.md template/thesis.typ
```

提交信息用 Conventional Commits，工作区保持干净。

## 2. 确认版本号未被占用

```sh
cd <fork>
git fetch upstream main
git ls-tree --name-only upstream/main -- packages/preview/modern-scut-thesis/
```

## 3. 切分支并导出

```sh
cd <fork>
git switch -c modern-scut-thesis-<版本> upstream/main
git branch --unset-upstream

# 回到源仓导出
git archive --prefix=packages/preview/modern-scut-thesis/<版本>/ HEAD | tar -x -C <fork>
git -C <fork> status --short
```

导出清单自检：不含 `scripts/`、`.github/`、PDF；含 `LICENSE`、`README.md`、`thumbnail.png`（长边 ≥1080 px、≤3 MiB）。

## 4. 隔离验证

把导出内容当作已安装的包，走用户的第一步：

```sh
tmp=$(mktemp -d)
mkdir -p "$tmp/packages/preview/modern-scut-thesis/<版本>"
git archive HEAD | tar -x -C "$tmp/packages/preview/modern-scut-thesis/<版本>"

typst init @preview/modern-scut-thesis:<版本> "$tmp/proj" --package-path "$tmp/packages"
for v in final blind for-print; do
  case $v in
    final)      args=() ;;
    blind)      args=(--input profile=blind --input blind=single) ;;
    for-print)  args=(--input profile=for-print) ;;
  esac
  typst compile --package-path "$tmp/packages" "${args[@]}" \
    "$tmp/proj/thesis.typ" "$tmp/proj/$v.pdf"
done
```

编译失败说明包内容不自足（漏文件、误 export-ignore 或未提交）。

## 5. 提交、推送、开 PR

```sh
cd <fork>
git add packages/preview/modern-scut-thesis/<版本>
git commit -m "Add modern-scut-thesis v<版本>"
git push -u origin modern-scut-thesis-<版本>

gh pr create --repo typst/packages --head snow-trap:modern-scut-thesis-<版本> \
  --title "modern-scut-thesis:<版本>" --body-file <正文>
```

PR 正文结构（0.1.1、0.1.2 均为此形）：

```markdown
I am submitting
- [ ] a new package
- [x] an update for a package

Description: <一句包简介，如 `modern-scut-thesis` is a thesis template for the South China University of Technology (SCUT), covering master's and doctoral theses.>

Changes in <版本>:

- <一句话概括用户可感知的改动>

- [x] ensured that my package is licensed such that users can use and distribute the contents of its template directory without restriction, after modifying them through normal use.
```

- `Changes` 写用户能感知的结果，不必逐条穷举所有 fix，内部重构不写；纯修复型发版一行概括即可
- 仅首次发布勾 `a new package`；删掉新包清单与模板里的 HTML 注释

等 CI 的 Lint / Test / typst.app 预览全绿。

## 6. 合并后

核对上游内容与本地导出一致：

```sh
cd <fork>
git fetch upstream main
git archive upstream/main packages/preview/modern-scut-thesis/<版本> | tar -x -C /tmp/pub
diff -rq <源仓导出目录> /tmp/pub/packages/preview/modern-scut-thesis/<版本>
```

打附注标签并推送（指向导出成包的那个提交）：

```sh
git tag -a v<版本> <提交> -m "<一句话说明>"
git push origin v<版本>
```

可选：写 changelog / 建 GitHub Release、删除 fork 上已合并的分支、`git -C <fork> merge --ff-only upstream/main`。

## 易错点

- **合并前不要打标签**：审核要求改动时，已推送的标签只能 force-move
- **PR 页面没有跨版本 diff**（全是新增文件），维护者靠 CI 与 Description 判断，所以 Description 是唯一的人类可读变更信号
- **编译器最低版本提升属于兼容性变化**：PR 描述可以不写，changelog 必须写
- 忘了改版本号就只能发再下一个版本——版本目录不可覆盖
