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
    
    @IBOutlet var resetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        designTextFieldUI()
        designTextViewUI()
        designLabelUI()
        designButtonUI()
        setupTextViewResult()
    }

    private func designTextFieldUI() {
        let placeholder = "최대 숫자를 입력해주세요"
        numberTextField.placeholder = placeholder
        numberTextField.textAlignment = .center
        numberTextField.borderStyle = .line
        numberTextField.keyboardType = .numbersAndPunctuation
        numberTextField.font = .systemFont(ofSize: 18)
    }

    private func designTextViewUI() {
        resultTextView.font = .systemFont(ofSize: 18)
        resultTextView.textColor = .gray
        resultTextView.textAlignment = .center
        resultTextView.isEditable = false
    }

    private func designLabelUI() {
        resultLabel.text = "숫자 입력 대기중.."
        resultLabel.font = .boldSystemFont(ofSize: 24)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
    }

    private func designButtonUI() {
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.backgroundColor = .paseutelPink
        resetButton.layer.cornerRadius = 12
        resetButton.clipsToBounds = true
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

        guard number > 0 && number <= 100000 else {
            showAlert("1 ~ 100,000까지의 숫자만 입력해주세요")
            return []
        }

        let numberRange = Range(1...number)
        var numberArr = [Int]()
        numberArr.append(contentsOf: numberRange)

        var strArr = [String]()
        strArr = numberArr.map { String($0) }
        var resultArr = [String]()


        // 100 입력했을 때, 0.00017404초
        // 1000 입력했을 때, 0.00213301초
        // 10000 입력했을 때, 0.0105509초
        // 100000 입력했을 때, 0.0498399초

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

    private func showAlert(_ title: String) {
        let alert = UIAlertController(title: "경고", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }


    @IBAction func textFieldEndExit(_ sender: UITextField) {
        setupTextViewResult()
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        clapCount = 0
        resultLabel.text = "숫자 입력 대기중.."
        resultTextView.text = ""
        numberTextField.text = ""
    }
}
