//
//  HistoricDataRemoteDataSource.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case parseError
    case invalidData
}

protocol ApiClient {
    func fetchData<T>(url: String) async throws -> T
}
