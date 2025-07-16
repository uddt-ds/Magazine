//
//  CountryTableViewCell.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import UIKit
import Kingfisher

class CountryTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var characterBgView: UIView!
    @IBOutlet var characterLabel: UILabel!
    @IBOutlet var imageAlphaView: UIView!
    @IBOutlet var bgImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabelUI()
        setupBgImageView()
        setupBgView()
        setBackground()
    }

    private func setBackground() {
        backgroundColor = .clear
        bgView.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    private func setupLabelUI() {
        countryLabel.designLabelUI(font: .boldSystemFont(ofSize: 28), color: .white)
        countryLabel.textAlignment = .right

        characterLabel.designLabelUI(font: .boldSystemFont(ofSize: 16), color: .white)
    }

    private func setupBgImageView() {
        [bgImageView, imageAlphaView].forEach {
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                      .layerMinXMinYCorner]
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }

        bgImageView.contentMode = .scaleAspectFill
        imageAlphaView.backgroundColor = .black.withAlphaComponent(0.2)

    }

    private func setupBgView() {
        characterBgView.backgroundColor = .black.withAlphaComponent(0.4)
        characterBgView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        characterBgView.layer.cornerRadius = 20
        characterBgView.clipsToBounds = true
    }

    func configureCell(with data: City) {
        countryLabel.text = "\(data.cityName) | \(data.cityEnglishName)"
        characterLabel.text = data.cityExplain

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
