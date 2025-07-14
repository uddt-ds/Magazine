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
        self.description = description != nil ? description : ""
        self.travelImage = travel_image != nil ? travel_image : ""
        self.grade = grade != nil ? grade : 0
        self.save = save != nil ? save : 0
        self.like = like != nil ? like : false
        self.ad = ad
    }

    // TODO: 연산 프로퍼티를 쓰면 cell에서 굳이 타입을 바꿔가면서 데이터 주입을 안해줘도 되지 않을까?
    var gradeDescription: String {
        return String(describing: grade ?? 0)
    }

    var saveDescription: String {
        return String(describing: save!.formatted(.number))
    }

    var gradeNumber: Double {
        return grade!
    }

    var urlString: String {
        return travelImage!
    }
//    mutating func changeValue() {
//        self.like?.toggle()
//    }
}

