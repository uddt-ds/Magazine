//
//  Travel.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import Foundation

struct Travel {
    let title: String
    let description: String?
    let travelImage: String?
    let grade: Double?
    var save: Int?
    var like: Bool?
    let ad: Bool
//    let id = UUID()

    init(title: String, description: String?, travel_image: String?, grade: Double?, save: Int?, like: Bool?, ad: Bool) {
        self.title = title
        self.description = description
        self.travelImage = travel_image
        self.grade = grade
        self.save = save
        self.like = like
        self.ad = ad
    }

//    mutating func changeValue() {
//        self.like?.toggle()
//    }
}

