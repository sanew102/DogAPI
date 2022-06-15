//
//  DogAPI.swift
//  DogAPI
//
//  Created by Нурым Нагиметов on 11.06.2022.
//

import Foundation
import UIKit
class DogAPI {
    enum EndPoint: String {
        case randomImageFromAllCollections = "https://dog.ceo/api/breeds/image/random"
        var url: URL  {
            return URL(string: self.rawValue)!
        }
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
    
    class func requestRandemImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndPoins = DogAPI.EndPoint.randomImageFromAllCollections.url
        let task = URLSession.shared.dataTask(with: randomImageEndPoins) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
}
