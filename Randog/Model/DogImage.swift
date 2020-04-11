//
//  DogImage.swift
//  Randog
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import Foundation

struct DogImage: Codable {
    let status: String
    let message: String
//
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
}
