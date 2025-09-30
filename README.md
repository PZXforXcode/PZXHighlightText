 - [简体中文](#简体中文) | [English](#english)

## 简体中文

### 项目简介
`PZXHighlightText` 是一个为 `UILabel` 提供轻量的文本高亮与点击回调的组件，适合聊天关键字命中、搜索结果高亮、富文本展示等场景。

### 功能特性
- 高亮多段文本并自定义颜色
- 支持点击高亮文本回调，获取具体命中文字
- 兼容 `UILabel` 对齐方式（含居中、右对齐、RTL）
- API 简洁，零侵入，便于集成


### 环境要求
- Xcode 15+
- iOS 13+
- Swift 5.7+

### 安装与集成
- 手动集成（推荐现阶段）
  - 将 `PZXHighlightText` 目录下源码添加到你的 Xcode 工程
  - 目标文件：`PZXHighlightText/PZXHighlightText/UILabel+Highlight.swift`

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



### 注意事项
- 文本变更或 label 复用时，应重新调用 `setHighlightText`，确保手势与范围同步

### 常见问题（FAQ）
- Q: 同一关键词多次出现如何全部高亮？
  - A: 当前仅匹配首个位置，可扩展为遍历所有 range 后批量添加 attributes。
- Q: 点击无反应或偏移？
  - A: 确认 `label.bounds` 已布局完成；对齐方式变化后需重新设置高亮；确保未被其他手势拦截。

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



### Requirements
- Xcode 15+
- iOS 13+
- Swift 5.7+

### Installation
- Manual integration (recommended for now)
  - Add the source files under `PZXHighlightText` to your Xcode project
  - Target file: `PZXHighlightText/PZXHighlightText/UILabel+Highlight.swift`


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





### Notes
- When text changes or the label is reused, call `setHighlightText` again to refresh gestures and ranges
- If you need case-insensitive or all occurrences, extend the current implementation to enumerate all ranges

### FAQ
- Q: How to highlight all occurrences of the same keyword?
  - A: Extend the logic to enumerate all ranges and apply attributes to each.


### License
- See `LICENSE` in the repository root

### Author & Acknowledgements
- Author: pengzuxin
- Contributions via Issues/PRs are welcome
