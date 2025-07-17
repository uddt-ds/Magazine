//
//  CollectionViewTravelCell.swift
//  Magazine
//
//  Created by Lee on 7/17/25.
//

import UIKit

final class CollectionViewTravelCell: UICollectionViewCell {

    @IBOutlet var travelImageView: UIImageView!

    @IBOutlet var labelStackView: UIStackView!

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        designTravelImageView()
        designStackView()
        setupLabel()
    }

    private func designTravelImageView() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.clipsToBounds = true
    }

    private func designStackView() {
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.alignment = .center
        labelStackView.spacing = 4
    }

    private func setupLabel() {
        mainLabel.designLabelUI(font: .boldSystemFont(ofSize: 14), color: .black)
        mainLabel.textAlignment = .center
        descriptionLabel.designLabelUI(font: .boldSystemFont(ofSize: 12), color: .gray, lines: 0)
        descriptionLabel.textAlignment = .center
    }

    func configureCell(with data: City) {
        guard let url = URL(string: data.cityImage) else { return }
        travelImageView.kf.setImage(with: url)
        mainLabel.text = "\(data.cityName) | \(data.cityEnglishName)"
        descriptionLabel.text = data.cityExplain
    }

    func configureImage(with radius: CGFloat) {
        travelImageView.layer.cornerRadius = radius
    }

    func configureLabel(keyword: String) {
        [mainLabel, descriptionLabel].forEach {
            $0?.asColor(targetString: keyword, color: .blue)
        }
    }
}
