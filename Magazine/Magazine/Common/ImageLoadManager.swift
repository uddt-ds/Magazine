//
//  ImageLoadManager.swift
//  Magazine
//
//  Created by Lee on 7/18/25.
//

import UIKit
import ImageIO

final class ImageLoadManager {
    static let shared = ImageLoadManager()

    private init() { }

    func donwloadImage(urlString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else {
            print("잘못된 URL입니다")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("이미지 다운로드 실패", error)
                return
            }

            guard let data else {
                print("데이터가 없습니다")
                return
            }

            completion(data)
        }.resume()
    }

    // WWDC 코드
    static func downsample(data: Data, to size: CGSize, scale: CGFloat) -> UIImage? {
        // 이미지 소스를 생성할 때 사용할 옵션, 이미지 소스를 만들 때 캐시를 사용할지에 대한 여부 체크
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary

        // CGImageSource는 이미지 데이터를 읽기 위한 타입(메타데이터에 접근할때도 사용)
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
                return nil
            }

        // 최대 픽셀 크기를 계산하고
        let maxDimension = max(size.width, size.height) * scale

        // 다운 샘플링에서 사용할 옵션들을 선택해줌
        let downsampleOptions = [
          kCGImageSourceCreateThumbnailFromImageAlways: true,   // 썸네일을 항상 만들지 말지
          kCGImageSourceShouldCacheImmediately: true,     // 이미지 생성과 동시에 캐시가 바로 진행될 것인지
          kCGImageSourceCreateThumbnailWithTransform: true,    // 썸네일 이미지를 원본 비율에 맞게 조정할 것인지
          kCGImageSourceThumbnailMaxPixelSize: maxDimension     // 썸네일 이미지의 최대 픽셀 크기
        ] as CFDictionary

        // 이미지 소스의 첫번째 이미지에 대해 썸네일을 생성
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }

        return UIImage(cgImage: downsampledImage)
    }
}
