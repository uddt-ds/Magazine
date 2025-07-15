//
//  AdDetailViewController.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet var adDetailLabel: UILabel!

    var adDetailTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupAdLabel()
        setupNav()
    }

    private func setupLabel() {
        adDetailLabel.designLabelUI(font: .boldSystemFont(ofSize: 24), color: .black, lines: 0)
        adDetailLabel.textAlignment = .center
    }

    private func setupNav() {
        let image = UIImage(systemName: "xmark")
        let leftItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.leftBarButtonItem?.tintColor = .black

        navigationItem.title = "광고 화면"
    }

    private func setupAdLabel() {
        adDetailLabel.text = adDetailTitle
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
}
