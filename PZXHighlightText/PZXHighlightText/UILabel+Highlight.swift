import UIKit

extension UILabel {
    /// 设置富文本文字，支持点击部分文字回调
    /// - Parameters:
    ///   - fullText: 整体字符串
    ///   - highlights: 需要高亮的文字及颜色（仅匹配首个出现位置）
    ///   - defaultColor: 默认文字颜色
    ///   - font: 默认字体
    ///   - onTap: 点击回调，返回点击的高亮文字
    public func setHighlightText(fullText: String,
                                 highlights: [(text: String, color: UIColor)],
                                 defaultColor: UIColor = .black,
                                 font: UIFont = UIFont.systemFont(ofSize: 14),
                                 onTap: ((String) -> Void)? = nil) {
        isUserInteractionEnabled = true

        // 富文本
        let attributed = NSMutableAttributedString(string: fullText)
        attributed.addAttributes([
            .foregroundColor: defaultColor,
            .font: font
        ], range: NSRange(location: 0, length: (fullText as NSString).length))

        var highlightRanges: [(NSRange, String)] = []
        for item in highlights {
            if let r = fullText.range(of: item.text) {
                let nsr = NSRange(r, in: fullText)
                attributed.addAttributes([.foregroundColor: item.color], range: nsr)
                highlightRanges.append((nsr, item.text))
            }
        }
        attributedText = attributed

        // 移除旧手势
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
        // 添加新手势
        let tap = HighlightTapGestureRecognizer(ranges: highlightRanges, onTap: onTap)
        addGestureRecognizer(tap)
    }
}

private class HighlightTapGestureRecognizer: UITapGestureRecognizer {
    private let highlightRanges: [(NSRange, String)]
    private let onTap: ((String) -> Void)?

    init(ranges: [(NSRange, String)], onTap: ((String) -> Void)?) {
        self.highlightRanges = ranges
        self.onTap = onTap
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(handleTap(_:)))
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel,
              let attributedText = label.attributedText else { return }

        let locationInLabel = gesture.location(in: label)

        // TextKit
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode

        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        // usedRect 偏移，考虑对齐
        let usedRect = layoutManager.usedRect(for: textContainer)
        let totalSize = label.bounds.size
        let horizontalOffset: CGFloat
        switch label.textAlignment {
        case .center:
            horizontalOffset = (totalSize.width - usedRect.width) * 0.5 - usedRect.origin.x
        case .right, .natural where UIView.userInterfaceLayoutDirection(for: label.semanticContentAttribute) == .rightToLeft:
            horizontalOffset = (totalSize.width - usedRect.width) - usedRect.origin.x
        default:
            horizontalOffset = -usedRect.origin.x
        }
        let verticalOffset: CGFloat = -usedRect.origin.y
        let point = CGPoint(x: locationInLabel.x - max(0, horizontalOffset), y: locationInLabel.y - max(0, verticalOffset))

        // glyph 命中
        let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
        let glyphRect = layoutManager.boundingRect(forGlyphRange: NSRange(location: glyphIndex, length: 1), in: textContainer)
        guard glyphRect.contains(point) else { return }
        let charIndex = layoutManager.characterIndexForGlyph(at: glyphIndex)

        for (range, word) in highlightRanges {
            if NSLocationInRange(charIndex, range) {
                onTap?(word)
                break
            }
        }
    }
}


