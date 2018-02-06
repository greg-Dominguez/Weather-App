//
//  Extensions+UIImageView.swift
//  Umbrella
//
//  Created by Greg Dominguez on 10/5/17.
//  Copyright © 2017 greg.dominguez. All rights reserved.
//

import UIKit

fileprivate let weatherImageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString: String){
        
        // if we have cached the image, use that
        if let cachedImage = weatherImageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let e = error {
                print(e)
                self?.applyImage(image: nil)
                return
            }
            
            guard let imageData = data,
                let image = UIImage(data: imageData) else {
                    
                    self?.applyImage(image: nil)
                    return
            }
            
            weatherImageCache.setObject(image, forKey: urlString as NSString)
            self?.applyImage(image: image)
            
            }.resume()
    }
    
    private func applyImage(image: UIImage?){
        DispatchQueue.main.async {
            self.image = image
        }
    }

}
