//
//  Breeds.swift
//  DogAPI
//
//  Created by Нурым Нагиметов on 27.06.2022.
//

import Foundation
struct BreedsListResponse: Codable {
    let message: [String: [String]]
    let status: String
}
