//
//  BreedsListResponse.swift
//  Randog
//
//  Created by user on 11.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
