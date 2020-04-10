//
//  DogAPI.swift
//  Randog
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class DogAPI {
    
    enum Enpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) -> Void {
        let randomImageEnpoint =  DogAPI.Enpoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEnpoint, completionHandler: {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        })
        
        task.resume()
        
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let data = data else { return }
            let downloadedImage = UIImage(data:data)
            completionHandler(downloadedImage, nil)
            
        })
        task.resume()
    }
    
}
