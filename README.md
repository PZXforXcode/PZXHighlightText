 - [简体中文](#简体中文) | [English](#english)

## 简体中文

### 项目简介
`PZXHighlightText` 是一个为 `UILabel` 提供轻量的文本高亮与点击回调的组件，适合聊天关键字命中、搜索结果高亮、富文本展示等场景。

### 功能特性
- 高亮多段文本并自定义颜色
- 支持点击高亮文本回调，获取具体命中文字
- 兼容 `UILabel` 对齐方式（含居中、右对齐、RTL）
- API 简洁，零侵入，便于集成

### 预览
- 可插入 GIF/截图（如有素材请提供，我可补充）

### 环境要求
- Xcode 15+
- iOS 13+
- Swift 5.7+

### 安装与集成
- 手动集成（推荐现阶段）
  - 将 `PZXHighlightText` 目录下源码添加到你的 Xcode 工程
  - 目标文件：`PZXHighlightText/PZXHighlightText/UILabel+Highlight.swift`
- Swift Package Manager
  - 目前工程非 SPM 包形式。如你需要，我可协助抽成独立 SPM 包

### 快速开始
```swift
import UIKit

let label = UILabel()
label.numberOfLines = 0
label.textAlignment = .left

let text = "欢迎使用 PZXHighlightText，高亮你的关键词！"
label.setHighlightText(
    fullText: text,
    highlights: [
        (text: "PZXHighlightText", color: .systemBlue),
        (text: "高亮", color: .systemRed)
    ],
    defaultColor: .label,
    font: UIFont.systemFont(ofSize: 16)
) { tapped in
    print("点击了高亮词：\(tapped)")
}
```

### API 速查
- 方法：`UILabel.setHighlightText(fullText:highlights:defaultColor:font:onTap:)`
  - `fullText`: 整体字符串
  - `highlights`: 需要高亮的文本与对应颜色数组（仅匹配每个词首个出现位置）
  - `defaultColor`: 非高亮文本颜色，默认 `.black`
  - `font`: 字体，默认 `system 14`
  - `onTap`: 点击某个高亮文本时的回调，参数为被点击的词
- 行为说明：
  - 使用 `NSMutableAttributedString` 设定基础样式与高亮色
  - 通过 TextKit 将触点映射到 glyph/character 索引并匹配高亮范围
  - 每个高亮词目前仅匹配首个出现位置（如需全量匹配可扩展）

### 进阶用法
- 多段高亮：在 `highlights` 里追加更多 `(text, color)` 项
- 对齐与布局：支持 `.left/.center/.right` 及 RTL；内部根据 `usedRect` 做点击区域偏移
- 与富文本叠加：若你已有其他富文本样式，建议先设置基础样式，再调用高亮逻辑

### 注意事项
- 文本变更或 label 复用时，应重新调用 `setHighlightText`，确保手势与范围同步
- 若需要大小写不敏感、全量匹配或样式叠加（如下划线、背景色），可在现有实现上扩展

### 常见问题（FAQ）
- Q: 同一关键词多次出现如何全部高亮？
  - A: 当前仅匹配首个位置，可扩展为遍历所有 range 后批量添加 attributes。
- Q: 点击无反应或偏移？
  - A: 确认 `label.bounds` 已布局完成；对齐方式变化后需重新设置高亮；确保未被其他手势拦截。

### 路线图（可选）
- 支持多次出现的全量匹配
- 支持更多样式（背景色、下划线、粗体等）
- 可选的 SPM 化与 Demo App 增强

### 许可证
- 见仓库根目录 `LICENSE`

### 作者与致谢
- 作者：pengzuxin
- 欢迎提交 Issue/PR 进行改进

---

## English

### Overview
`PZXHighlightText` is a lightweight extension for `UILabel` to highlight multiple text segments and receive tap callbacks, ideal for chat keyword hits, search results highlighting, and rich text displays.

### Features
- Highlight multiple segments with custom colors
- Tap callback with the exact tapped highlighted word
- Works with `UILabel` text alignment (center, right, RTL included)
- Minimal, easy-to-use API

### Preview
- Place GIF/screenshots here (share assets if available)

### Requirements
- Xcode 15+
- iOS 13+
- Swift 5.7+

### Installation
- Manual integration (recommended for now)
  - Add the source files under `PZXHighlightText` to your Xcode project
  - Target file: `PZXHighlightText/PZXHighlightText/UILabel+Highlight.swift`
- Swift Package Manager
  - The project is not yet structured as a package. If needed, I can help convert it to an SPM package.

### Quick Start
```swift
import UIKit

let label = UILabel()
label.numberOfLines = 0
label.textAlignment = .left

let text = "Welcome to PZXHighlightText, highlight your keywords!"
label.setHighlightText(
    fullText: text,
    highlights: [
        (text: "PZXHighlightText", color: .systemBlue),
        (text: "highlight", color: .systemRed)
    ],
    defaultColor: .label,
    font: UIFont.systemFont(ofSize: 16)
) { tapped in
    print("Tapped highlight: \(tapped)")
}
```

### API Quick Reference
- Method: `UILabel.setHighlightText(fullText:highlights:defaultColor:font:onTap:)`
  - `fullText`: full string
  - `highlights`: array of `(text, color)`; matches only the first occurrence per item
  - `defaultColor`: default text color, default `.black`
  - `font`: font, default `system 14`
  - `onTap`: callback invoked with the tapped highlighted word
- Behavior:
  - Uses `NSMutableAttributedString` for base style and highlight colors
  - Uses TextKit to map touch point to glyph/character index and check highlight ranges
  - Each keyword currently matches only its first occurrence

### Advanced
- Multiple highlights: provide more `(text, color)` items in `highlights`
- Alignment & layout: supports `.left/.center/.right` and RTL; internal offset aligns hit-testing
- Rich text composition: apply base styles first, then call highlight to avoid overrides

### Notes
- When text changes or the label is reused, call `setHighlightText` again to refresh gestures and ranges
- If you need case-insensitive or all occurrences, extend the current implementation to enumerate all ranges

### FAQ
- Q: How to highlight all occurrences of the same keyword?
  - A: Extend the logic to enumerate all ranges and apply attributes to each.
- Q: Taps not detected or offset?
  - A: Ensure `label.bounds` is laid out; re-apply highlights after alignment changes; check gesture conflicts.

### Roadmap (optional)
- All-occurrence matching
- More styles (background, underline, bold)
- Optional SPM packaging and a richer demo app

### License
- See `LICENSE` in the repository root

### Author & Acknowledgements
- Author: pengzuxin
- Contributions via Issues/PRs are welcome
