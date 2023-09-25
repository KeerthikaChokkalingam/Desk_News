//
//  CustomImageView.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 13/09/23.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(urlString: String) {
        self.image = nil
        
        if let task = task {
            task.cancel()
        }
        let url = URL(string: urlString)
        guard let url else { return }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let newImage = UIImage(data: data) else {
//                print("Cannot load image from url: \(url)")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.image = newImage
            }
        }
        task.resume()
    }
}
