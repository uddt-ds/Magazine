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
}
