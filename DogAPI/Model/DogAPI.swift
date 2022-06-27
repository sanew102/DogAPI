//
//  DogAPI.swift
//  DogAPI
//
//  Created by Нурым Нагиметов on 11.06.2022.
//

import Foundation
import UIKit
class DogAPI {
    enum EndPoint {
        case randomImageFromAllCollections
        case randomImaheForBreed(String)
        case listAllBreeds
        var url: URL  {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .randomImageFromAllCollections:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImaheForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds: return "https://dog.ceo/api/breeds/list/all"
            default: return ""
            }
        }
    }
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error? ) -> Void) {
        let task = URLSession.shared.dataTask(with: EndPoint.listAllBreeds.url) { data, response, error in
            guard let data = data else {
                completionHandler([],error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    
    class func reguestImageFile(url: URL, completionHandler: @escaping (UIImage? , Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downnloadedImage = UIImage(data: data)
            completionHandler(downnloadedImage, nil)
        })
        task.resume()
    }
    
    class func requestRandemImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndPoins = DogAPI.EndPoint.randomImaheForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndPoins) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
}
