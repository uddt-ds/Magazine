//
//  TravelTableViewCell.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import UIKit
import Kingfisher

final class TravelCell: UITableViewCell {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var imageStackView: UIStackView!
    @IBOutlet var stackImageViews: [UIImageView]!
    @IBOutlet var countLabel: UILabel!

    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainLabel()
        setupSubLabel()
        designStackImageUI()
        designCountLabelUI()
        designLikeButton()
        designStackView()
        designImageView()
    }

    private func designLabelUI(_ label: UILabel, font: UIFont, color: UIColor, lines: Int = 1) {
        label.font = font
        label.textColor = color
        label.numberOfLines = lines
    }

    private func setupMainLabel() {
        designLabelUI(mainLabel, font: .boldSystemFont(ofSize: 20), color: .black)
    }

    private func setupSubLabel() {
        designLabelUI(subLabel, font: .systemFont(ofSize: 14), color: .gray, lines: 0)
    }

    private func designStackImageUI() {
        let nonStarImage = UIImage(systemName: "star.fill")
        stackImageViews.forEach {
            $0.image = nonStarImage
            $0.tintColor = .lightGray
        }
    }

    private func designStackView() {
        imageStackView.alignment = .center
    }

    private func designCountLabelUI() {
        designLabelUI(countLabel, font: .systemFont(ofSize: 14), color: .lightGray)
    }

    private func setupImage(grade: Double) {
        let nonFillStarImage = UIImage(systemName: "star")
        let starImage = UIImage(systemName: "star.fill")
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")

        let (firstNum,lastNum) = modf(grade)
        let currentFirstNum = Int(firstNum)
        let starCount = 5

        for i in 0..<starCount {
            stackImageViews[i].image = nonFillStarImage
            stackImageViews[i].tintColor = .systemGray3
        }

        for i in 0..<currentFirstNum {
            stackImageViews[i].image = starImage
            stackImageViews[i].tintColor = .systemYellow
        }

        if lastNum >= 0.5 {
            stackImageViews[currentFirstNum].image = halfStarImage
            stackImageViews[currentFirstNum].tintColor = .systemYellow
        }
    }

    private func designLikeButton() {
        let heartImage = UIImage(systemName: "heart")
        likeButton.setImage(heartImage, for: .normal)
        likeButton.tintColor = .white
    }

    private func designImageView() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 10
        travelImageView.clipsToBounds = true
    }

    func configureCell(_ data: Travel) {
        let heartImage = UIImage(systemName: "heart")
        let heartFillImage = UIImage(systemName: "heart.fill")

        mainLabel.text = data.title
        subLabel.text = data.description
        setupImage(grade: data.gradeNumber)

        let processor = DownsamplingImageProcessor(size: travelImageView.bounds.size)

        if let url = URL(string: data.urlString) {
            travelImageView.kf.indicatorType = .activity
            travelImageView.kf.setImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        }

        countLabel.text = "\(data.gradeDescription) • 저장 \(data.saveDescription)"

        if data.like == true {
            likeButton.setImage(heartFillImage, for: .normal)
        } else {
            likeButton.setImage(heartImage, for: .normal)
        }
    }
}
