//
//  UIViewController+Extension.swift
//  Magazine
//
//  Created by Lee on 7/14/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: style)

        let okButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okButton)

        present(alert, animated: true)
    }
}
