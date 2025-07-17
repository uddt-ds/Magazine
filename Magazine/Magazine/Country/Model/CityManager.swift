//
//  CityManager.swift
//  Magazine
//
//  Created by Lee on 7/17/25.
//

import Foundation

struct CityManager {
    let cityInfo = CityInfo().city

    var domesticData: [City] {
        return cityInfo.filter { $0.domesticTravel }
    }

    var overseaData: [City] {
        return cityInfo.filter { !$0.domesticTravel }
    }
}
