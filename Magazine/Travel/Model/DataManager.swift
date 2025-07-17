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
        return travelInfo.travel.filter { !$0.ad }.map {
            Travel(title: $0.title,
                   description: $0.description ?? "",
                   travel_image: $0.travelImage ?? "",
                   grade: $0.grade ?? 0,
                   save: $0.save ?? 0,
                   like: $0.like ?? true,
                   ad: $0.ad)
        }
    }

    var adData: [AdData] {
        return travelInfo.travel.filter { $0.ad }.map {
            AdData(title: $0.title)
        }
    }

//    func travelDataList() -> [TravelData] {
//        return travelData
//            .map {
//                TravelData(title: $0.title,
//                           description: $0.description ?? "",
//                           travelImage: $0.travelImage ?? "",
//                           grade: $0.grade ?? 0,
//                           save: $0.save ?? 0,
//                           like: $0.like ?? true)
//            }
//    }
//
//    func adDataList() -> [AdData] {
//        return adData
//            .map {
//                AdData(title: $0.title)
//            }
//    }

//    var travelData: [Travel] {
//        return travelInfo.travel.filter { !$0.ad }
//    }
//
//    var adData: [Travel] {
//        return travelInfo.travel.filter { $0.ad }
//    }
//
//    func travelDataList() -> [TravelData] {
//        return travelData
//            .map {
//                TravelData(title: $0.title,
//                           description: $0.description ?? "",
//                           travelImage: $0.travelImage ?? "",
//                           grade: $0.grade ?? 0,
//                           save: $0.save ?? 0,
//                           like: $0.like ?? true)
//            }
//    }
//
//    func adDataList() -> [AdData] {
//        return adData
//            .map {
//                AdData(title: $0.title)
//            }
//    }

    // 컴파일러가 개선해준 as! T의 경우 적절한 방식은 아닌거 같음
//    func getDataList<T>(_ bool: Bool) -> [T] {
//        if bool {
//            return travelData.map { data in
//                TravelData(title: data.title,
//                           description: data.description ?? "",
//                           travelImage: data.travelImage ?? "",
//                           grade: data.grade ?? 0,
//                           save: data.save ?? 0,
//                           like: data.like ?? true) as! T
//            }
//        } else {
//            return adData.map { data in
//                AdData(title: data.title) as! T
//            }
//        }
//    }
}

