//
//  CountryDetailViewController.swift
//  Magazine
//
//  Created by Lee on 7/16/25.
//

import UIKit
import Kingfisher

final class CountryDetailViewController: UIViewController {

    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!

    var data: City = .init(city_name: "", city_english_name: "", city_explain: "", city_image: "", domestic_travel: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBgImageView()
        setupBgView()
        setupLabel()
        setupDescriptionLabel()
        configureUI()
    }

    private func setupBgView() {
        bgView.backgroundColor = .black.withAlphaComponent(0.6)
    }

    private func setupBgImageView() {
        bgImageView.contentMode = .scaleAspectFill
    }

    private func setupLabel() {
        let title = "당신을 위한 여행 보고서"
        titleLabel.text = title
        titleLabel.designLabelUI(font: .boldSystemFont(ofSize: 20), color: .white)
        countryLabel.designLabelUI(font: .boldSystemFont(ofSize: 36), color: .white)
        detailLabel.designLabelUI(font: .boldSystemFont(ofSize: 16), color: .white, lines: 0)
    }

    private func setupDescriptionLabel() {
        let title = "가볼 만한 곳"
        descriptionLabel.text = title
        descriptionLabel.designLabelUI(font: .boldSystemFont(ofSize: 18), color: .white)
    }

    func configureUI() {
        countryLabel.text = "\(data.cityName) | \(data.cityEnglishName)"


        detailLabel.text = " \(data.cityExplain.replacingOccurrences(of: ",", with: "\n"))"

        let url = URL(string: data.cityImage)

        let processor = DownsamplingImageProcessor(size: bgImageView.bounds.size)

        bgImageView.kf.indicatorType = .activity
        bgImageView.kf.setImage(with: url,
                                options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale)
        ])
    }
}
