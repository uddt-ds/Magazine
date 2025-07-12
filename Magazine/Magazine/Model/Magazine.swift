//
//  Magazine.swift
//  MagazineProject
//
//  Created by Lee on 7/11/25.
//

import Foundation

struct Magazine {
    let title: String
    let subTitle: String
    let photoImage: String
    let date: String
    let link: String

    init(title: String, subtitle: String, photo_image: String, date: String, link: String) {
        self.title = title
        self.subTitle = subtitle
        self.photoImage = photo_image
        self.date = date
        self.link = link
    }
}
