//
//  Travel.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import Foundation

//Todo: raw한 모델만 써야할까?
//모델을 여러개 정의하고 고차함수를 써서 사용할 수 있지 않을까?
struct Travel {
    let title: String
    let description: String?
    let travelImage: String?
    let grade: Double?
    var save: Int?
    var like: Bool?
    let ad: Bool
    
    init(title: String, description: String?, travel_image: String?, grade: Double?, save: Int?, like: Bool?, ad: Bool) {
        self.title = title
        self.description = description != nil ? description : ""
        self.travelImage = travel_image != nil ? travel_image : ""
        self.grade = grade != nil ? grade : 0
        self.save = save != nil ? save : 0
        self.like = like != nil ? like : false
        self.ad = ad
    }
    
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

//    // TODO: Bool값에 따라서 다르게 쏴주거나, 고차함수를 써서 각각 다르게 반환
//    func a() -> [TravelData] {
//
//    }
}

