//
//  ViewController.swift
//  PZXHighlightText
//
//  Created by 彭祖鑫 on 2025/9/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置示例标签（仅封装）
        setupHighlightDemoLabel()
    }

    /// 创建并展示一个示例 UILabel，演示高亮文本点击（封装版本）
    private func setupHighlightDemoLabel() {
        let demoLabel = UILabel()
        demoLabel.translatesAutoresizingMaskIntoConstraints = false
        demoLabel.numberOfLines = 0
        demoLabel.textAlignment = .left
        demoLabel.isUserInteractionEnabled = true
        view.addSubview(demoLabel)

        NSLayoutConstraint.activate([
            demoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            demoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            demoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])

        let highlightsString1 = "蓝色蓝色蓝色"
        let highlightsString2 = "绿色绿色绿色"

        let fullText = "欢迎使用 PZXHighlightText 示例，点击 \(highlightsString1)lkajdfklajdkjaslkj 或 \(highlightsString2) 试试吧！"
        let highlights: [(text: String, color: UIColor)] = [
            (text: highlightsString1, color: .systemBlue),
            (text: highlightsString2, color: .systemGreen)
        ]
        demoLabel.setHighlightText(fullText: fullText,
                                   highlights: highlights,
                                   defaultColor: .label,
                                   font: UIFont.systemFont(ofSize: 18)) { [weak self] word in
            self?.showTappedAlert(for: word)
        }
    }

    /// 弹窗展示被点击的高亮词
    /// - Parameter word: 点击的词
    private func showTappedAlert(for word: String) {
        let alert = UIAlertController(title: "点击提示",
                                      message: "你点击了：\(word)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

