//
//  UILabel+Extension.swift
//  Magazine
//
//  Created by Lee on 7/14/25.
//

import UIKit

extension UILabel {
    func designLabelUI(font: UIFont, color: UIColor, lines: Int = 1) {
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
    }

    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
