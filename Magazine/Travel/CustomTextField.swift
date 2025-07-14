//
//  CustomTextField.swift
//  Magazine
//
//  Created by Lee on 7/14/25.
//

import UIKit

class CustomTextField: UITextField {

    private var pasteBlocked: Bool = false

    var isPasteBlocked: Bool {
        get {
            self.pasteBlocked
        }
        set {
            self.pasteBlocked = newValue
        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if isPasteBlocked && action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
}
