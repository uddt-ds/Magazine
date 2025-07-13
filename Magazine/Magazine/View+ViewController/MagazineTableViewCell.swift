//
//  MagazineTableViewCell.swift
//  MagazineProject
//
//  Created by Lee on 7/11/25.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {

    @IBOutlet var magazineImageView: UIImageView!

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainLabel()
        setupSubLabel()
        setupDateLabel()
    }

    private func setupMainLabel() {
        designLabelUI(mainLabel, font: .boldSystemFont(ofSize: 20), color: .black, lines: 0)
    }

    private func setupSubLabel() {
        designLabelUI(subLabel, font: .systemFont(ofSize: 14), color: .gray)
    }

    private func setupDateLabel() {
        designLabelUI(dateLabel, font: .systemFont(ofSize: 12), color: .gray)
    }

    private func designLabelUI(_ label: UILabel, font: UIFont, color: UIColor, lines: Int = 1) {
        label.font = font
        label.textColor = color
        label.numberOfLines = lines
    }

    private func designImageViewUI() {
        magazineImageView.contentMode = .scaleAspectFill
        magazineImageView.layer.cornerRadius = 16
        magazineImageView.clipsToBounds = true
    }

    func configureCell(_ data: Magazine) {
        mainLabel.text = data.title
        subLabel.text = data.subTitle

        let dateData = data.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYMMdd"
        if let dateData = dateFormatter.date(from: dateData) {
            let formatter = DateFormatter()
            formatter.dateFormat = "YY년 MM월 dd일"
            let date = formatter.string(from: dateData)
            dateLabel.text = date
        }

        let url = URL(string: data.photoImage)
        designImageViewUI()
        magazineImageView.kf.setImage(with: url)
    }

}
