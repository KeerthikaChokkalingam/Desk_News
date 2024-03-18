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
    
    func loadImage(urlString: String, completion: ((String, Int) -> Void)? = nil) {
        self.image = nil
        
        if let task = task {
            task.cancel()
        }
        guard let url = URL(string: urlString) else {
            completion?("failure", 1)
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            completion?("success", 0)
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                completion?("failure", 1)
                return
            }
            
            if let newImage = UIImage(data: data) {
                imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = newImage
                    completion?("success", 0)
                }
            } else {
                completion?("failure", 1)
            }
        }
        task?.resume()
    }
    
    
}
