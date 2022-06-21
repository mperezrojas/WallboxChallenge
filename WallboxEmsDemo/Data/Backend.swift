//
//  Backend.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

class Backend: ApiClient {
    func fetchData<T>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw ApiError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let data = data as? T else {
            throw ApiError.invalidData
        }
        
        return data
    }
}

