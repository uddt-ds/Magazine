//
//  DataManager.swift
//  Magazine
//
//  Created by Lee on 7/12/25.
//

import Foundation

struct DataManager {
    var travelInfo = TravelInfo()

    var travelData: [Travel] {
        return travelInfo.travel.filter { !$0.ad }
    }

    var adData: [Travel] {
        return travelInfo.travel.filter { !$0.ad == false }
    }
}

