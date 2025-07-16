//
//  UIButton+Extension.swift
//  Magazine
//
//  Created by Lee on 7/16/25.
//

import UIKit

extension UIButton {
    func designButtonUI(title: String, titleColor: UIColor, bgColor: UIColor, radius: CGFloat, font: UIFont?, enabled: Bool = true) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = bgColor
        layer.cornerRadius = radius
        clipsToBounds = true
        titleLabel?.font = font
        isUserInteractionEnabled = enabled
    }
}
