//
//  CustonJsonDecoder.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class CustomJSONDecoder: JSONDecoder {
    required override init() {
        super.init()
        dateDecodingStrategy = .iso8601
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
