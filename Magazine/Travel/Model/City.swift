//
//  City.swift
//  Magazine
//
//  Created by Lee on 7/15/25.
//

import Foundation

struct City {
    let cityName: String
    let cityEnglishName: String
    let cityExplain: String
    let cityImage: String
    let domesticTravel: Bool

    init(city_name: String, city_english_name: String, city_explain: String, city_image: String, domestic_travel: Bool) {
        self.cityName = city_name
        self.cityEnglishName = city_english_name
        self.cityExplain = city_explain
        self.cityImage = city_image
        self.domesticTravel = domestic_travel
    }

    var upperKeyword: String {
        return cityEnglishName.uppercased()
    }
}
