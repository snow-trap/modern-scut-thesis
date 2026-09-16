# 本地开发

模板通过 `@preview/modern-scut-thesis:<版本号>` 导入包，版本以 `typst.toml` 的 `package.version` 为准。开发前，将 Typst 用户包目录中对应版本的路径软链接到当前仓库，确保编译使用本地源码，而不是已发布版本。

Linux 下，在仓库根目录执行：

```bash
version="<版本号>"
package="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/preview/modern-scut-thesis/$version"
mkdir -p "$(dirname "$package")"
ln -s "$(pwd -P)" "$package"
```

若路径已存在，先检查链接目标，不要直接覆盖；切换工作树时需调整链接，升级包版本时需同步更新路径。其他系统的用户包目录可通过 `typst info` 查看。

## 修改约定

修改时按以下职责放置代码：

```text
.
├── lib.typ       # 对外入口，通过 documentclass() 绑定配置、导出页面和布局
├── layouts/      # 通过 show 应用的跨页布局，如前言、正文和附录
├── pages/        # 独立页面，如封面、摘要和目录
├── utils/        # 共享功能，如字体字号、编号和定理环境
├── assets/       # 包内资源，如校徽
├── template/     # typst init 复制给用户的论文起始模板
└── scripts/      # 仓库开发用构建脚本，不随模板复制
```

字体、字号等共享配置沿用已有入口，不在各页面重复定义默认值。

提交说明参考本仓历史（`git log -10 --oneline`），采用 Conventional Commits。

## 版本号检查

`typst.toml` 的 `package.version` 是版本的唯一来源；模板与用户文档保留固定版本，在同一次发布变更中手动同步：

- [ ] 更新 `typst.toml` 中的包版本。
- [ ] 更新 `template/thesis.typ` 的包导入。
- [ ] 更新 `README.md` 的 `typst init` 命令及 Web 模板链接。
- [ ] 核对本地包软链接的版本与目标，编译模板并检查输出。

发布前可用以下命令检查本包引用:

```bash
rg -n 'modern-scut-thesis[:/]|version=' \
  README.md CONTRIBUTING.md template/thesis.typ
```
