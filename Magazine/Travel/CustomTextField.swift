//
//  CustomTextField.swift
//  Magazine
//
//  Created by Lee on 7/14/25.
//

import UIKit

/*
 CustomTextField에 pasteBlocked 프로퍼티를 false로 초기화
 isPasteBlocked는 get 할 때 false고,

 */

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
