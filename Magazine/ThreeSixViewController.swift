//
//  ThreeSixViewController.swift
//  Magazine
//
//  Created by Lee on 7/11/25.
//

import UIKit

final class ThreeSixViewController: UIViewController {

    var clapCount = 0

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTextFieldUI()
        designTextViewUI()
        designLabelUI()
        setupTextViewResult()
    }

    private func designTextFieldUI() {
        let placeholder = "최대 숫자를 입력해주세요"
        numberTextField.placeholder = placeholder
        numberTextField.textAlignment = .center
        numberTextField.borderStyle = .line
        numberTextField.font = .systemFont(ofSize: 18)
    }

    private func designTextViewUI() {
        resultTextView.font = .systemFont(ofSize: 18)
        resultTextView.textColor = .gray
        resultTextView.textAlignment = .center
        resultTextView.isEditable = false
    }

    private func designLabelUI() {
        resultLabel.text = "숫자 입력 대기중"
        resultLabel.font = .boldSystemFont(ofSize: 30)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
    }

//    private func getResult(_ input: String) -> [String] {
//        let number = Int(input) ?? 0
//        let numberRange = Range(1...number)
//        var numberArr = [Int]()
//        numberArr.append(contentsOf: numberRange)
//
//        var multipleThreeArr = [Int]()
//
//        for num in numberArr {
//            if num.isMultiple(of: 3) {
//                multipleThreeArr.append(num)
//            }
//        }
//
//        var strArr = [String]()
//        strArr = numberArr.map { String($0) }
//
//        multipleThreeArr.forEach { strArr[$0 - 1] = "👏" }
//
//        let clapCount = multipleThreeArr.count
//        resultLabel.text = "숫자 \(number)까지 \n총 박수는 \(clapCount)번 입니다."
//
//        return strArr
//    }

    private func checkContainsMultipleThree(_ input: String) -> [String] {
        clapCount = 0

        let number = Int(input) ?? 0
        let numberRange = Range(1...number)
        var numberArr = [Int]()
        numberArr.append(contentsOf: numberRange)

        var strArr = [String]()
        strArr = numberArr.map { String($0) }
        var resultArr = [String]()
        for str in strArr {
            let result = changeText(text: str)
            resultArr.append(result)
        }

        resultLabel.text = "숫자 \(number)까지 \n총 박수는 \(clapCount)번 입니다"

        return resultArr
    }

    private func changeText(text: String) -> String {
        var changeString = ""
        for char in text {
            if char == "3" || char == "6" || char == "9" {
                clapCount += 1
                changeString.append("👏")
            } else {
                changeString.append(char)
            }
        }

        return changeString
    }

    private func setupTextViewResult() {
        if numberTextField.text != "" {
            let text = checkContainsMultipleThree(numberTextField.text!)
            let joinedText = text.joined(separator: ", ")
            resultTextView.text = joinedText
        }
    }


    @IBAction func textFieldEndExit(_ sender: UITextField) {
        setupTextViewResult()
    }
    

}
