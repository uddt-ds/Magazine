//
//  AdDetailViewController.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet var topBarBgView: UIView!
    @IBOutlet var adDetailLabel: UILabel!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var navigationUnderLine: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupButton()
        setupUnderLine()
    }

    private func setupLabel() {
        let title = "광고 화면"
        topLabel.designLabelUI(font: .boldSystemFont(ofSize: 18), color: .black)
        topLabel.text = title
        adDetailLabel.designLabelUI(font: .boldSystemFont(ofSize: 20), color: .black, lines: 0)
        adDetailLabel.textAlignment = .center
    }

    private func setupButton() {
        let closeImage = UIImage(systemName: "xmark")
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = .black
    }

    private func setupUnderLine() {
        navigationUnderLine.backgroundColor = .gray
    }

    func configureUI(with data: Travel) {
        adDetailLabel.text = data.title
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
