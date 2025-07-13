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
    }

    private func designBgView() {
        
        adCellBgView.layer.cornerRadius = 14
        adCellBgView.clipsToBounds = true
    }

    private func designAdButton() {
        adButton.titleLabel?.text = "AD"
        adButton.titleLabel?.font = .systemFont(ofSize: 11)
        adButton.titleLabel?.textColor = .black
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

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
