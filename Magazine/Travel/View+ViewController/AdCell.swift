//
//  AdCell.swift
//  Magazine
//
//  Created by Lee on 7/13/25.
//

import UIKit

class AdCell: UITableViewCell {

    @IBOutlet var adCellBgView: UIView!
    @IBOutlet var adCellLabel: UILabel!
    @IBOutlet var adButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        designBgView()
        designAdButton()
        designAdLabel()
        makeGesture()
    }

    private func designBgView() {
        adCellBgView.layer.cornerRadius = 14
        adCellBgView.clipsToBounds = true
    }

    private func designAdButton() {
        adButton.setTitle("AD", for: .normal)
        adButton.setTitleColor(.black, for: .normal)
        adButton.titleLabel?.font = .systemFont(ofSize: 11)
        adButton.isUserInteractionEnabled = false
        adButton.backgroundColor = .white
        adButton.layer.cornerRadius = 10
        adButton.clipsToBounds = true
    }

    private func designAdLabel() {
        adCellLabel.font = .boldSystemFont(ofSize: 18)
        adCellLabel.numberOfLines = 0
        adCellLabel.textAlignment = .center
    }

    func configureLabel(_ data: Travel) {
        adCellLabel.text = data.title
    }

    private func makeGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(adViewTapped))
        adCellBgView.addGestureRecognizer(tapGesture)
    }

    @objc func adViewTapped() {
        makeToast("광고 셀입니다", duration: 2, position: .center)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hideToast()
    }
}
