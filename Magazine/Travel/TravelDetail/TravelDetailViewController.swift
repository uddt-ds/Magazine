//
//  TrabelDetailViewController.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit

final class TravelDetailViewController: UIViewController {

    static let identifier = "TravelDetailViewController"

    var data: Travel = .init(title: "",
                             description: "",
                             travel_image: "",
                             grade: 0.0,
                             save: 0,
                             like: false,
                             ad: false)

    @IBOutlet var detailStackView: UIStackView!
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var findButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupStackView()
        designDetailImageView()
        setupLabel()
        designButton()
        configureUI()
    }

    private func setupNavigation() {
        navigationItem.title = "관광지 화면"
    }

    private func setupStackView() {
        detailStackView.axis = .vertical
        detailStackView.alignment = .center
        detailStackView.spacing = 20
    }

    private func designDetailImageView() {
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.layer.cornerRadius = 12
        detailImageView.clipsToBounds = true
    }

    private func setupLabel() {
        mainLabel.designLabelUI(font: .boldSystemFont(ofSize: 36), color: .black)
        subLabel.designLabelUI(font: .boldSystemFont(ofSize: 24), color: .black, lines: 0)
        subLabel.textAlignment = .center
    }

    private func designButton() {
        let title = "다른 관광지 보러 가기"
        findButton.designButtonUI(title: title, titleColor: .white, bgColor: .systemIndigo, radius: 24, font: .boldSystemFont(ofSize: 16))
    }

    func configureUI() {
        if let url = URL(string: data.urlString) {
            detailImageView.kf.indicatorType = .activity
            detailImageView.kf.setImage(with: url)
        }

        mainLabel.text = data.title
        subLabel.text = data.description
    }

    @IBAction func findButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
