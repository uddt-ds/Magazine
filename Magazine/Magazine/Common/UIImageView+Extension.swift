//
//  UIImageView+Extension.swift
//  Magazine
//
//  Created by Lee on 7/18/25.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }

        ImageLoadManager.shared.donwloadImage(urlString: urlString) { [weak self] data in
            guard let self else {
                return
            }

            DispatchQueue.main.async {
                let targetSize = self.bounds.size == .zero ? CGSize(width: 200, height: 200) : self.bounds.size
                let scale = UIScreen.main.scale

                guard let image = ImageLoadManager.downsample(data: data, to: targetSize, scale: scale) else { return }

                ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                self.image = image
            }
        }
    }

    private func setImageDataFromUrlString(urlString: String) {
        ImageLoadManager.shared.donwloadImage(urlString: urlString) { data in
            DispatchQueue.main.async { [weak self] in
                guard let self, let image = UIImage(data: data) else { return }
                let cacheKey = NSString(string: urlString)
                ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                self.image = image
            }
        }
    }
}
