//
//  DataStorage.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

enum StorageError: Error {
    case saveError
    case notFound
}

protocol DataStorage {
    func save<T>(_ obj: T) async throws
    func fetch<T>() async throws -> T 
}
