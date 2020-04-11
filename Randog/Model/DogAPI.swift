//
//  DogAPI.swift
//  Randog
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//
//  https://dog.ceo/dog-api/documentation/

import UIKit

class DogAPI {
    
    enum Endpoint {
        
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"

            }
        }
    }
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            let sortedBreeds = breeds.sorted()
            completionHandler(sortedBreeds, nil)
            
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) -> Void {
        let randomImageEndpoint =  DogAPI.Endpoint.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint, completionHandler: {(data, response, error) in
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
