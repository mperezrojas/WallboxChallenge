//
//  LocalStorage.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class LocalStorage: DataStorage {
    var data: [HistoricDataResponse]?
    
    func save<T>(_ obj: T) async throws {
        guard let dataResponse = obj as? [HistoricDataResponse] else {
            throw StorageError.saveError
        }
        data = dataResponse
    }
    
    func fetch<T>() async throws -> T {
        guard let data = data as? T else {
            throw StorageError.notFound
        }
        
        return data
    }
}
