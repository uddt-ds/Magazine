//
//  ImageCacheManager.swift
//  Magazine
//
//  Created by Lee on 7/18/25.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() { }
}
