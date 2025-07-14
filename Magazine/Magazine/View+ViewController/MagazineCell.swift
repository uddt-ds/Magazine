//
//  MagazineTableViewCell.swift
//  MagazineProject
//
//  Created by Lee on 7/11/25.
//

import UIKit
import Kingfisher

class MagazineCell: UITableViewCell {

    @IBOutlet var magazineImageView: UIImageView!

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    let dateFormatter = DateFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainLabel()
        setupSubLabel()
        setupDateLabel()
    }

    private func setupMainLabel() {
        mainLabel.designLabelUI(font: .boldSystemFont(ofSize: 20), color: .black, lines: 0)
    }

    private func setupSubLabel() {
        subLabel.designLabelUI(font: .systemFont(ofSize: 14), color: .gray)
    }

    private func setupDateLabel() {
        dateLabel.designLabelUI(font: .systemFont(ofSize: 12), color: .gray)
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
        dateFormatter.dateFormat = "YYMMdd"
        if let dateData = dateFormatter.date(from: dateData) {
            dateFormatter.dateFormat = "YY년 MM월 dd일"
            let date = dateFormatter.string(from: dateData)
            dateLabel.text = date
        }

        let url = URL(string: data.photoImage)
        designImageViewUI()
        magazineImageView.kf.setImage(with: url)
    }
}
