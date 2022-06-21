//
//  HistoricDataRepository.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

class DataRepository: DataGateway {
    let remoteDataSource: ApiClient
    let localDataSource: DataStorage
    
    init(remoteDataSource: ApiClient, localDataSource: DataStorage) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchHistoricData() async throws -> [HistoricDataResponse] {
        
        if let savedData: [HistoricDataResponse] = try? await localDataSource.fetch() {
            return savedData
        }
        
        let data: Data = try await remoteDataSource.fetchData(url: Contants.historicDataUrl)

        guard let historicalData = try? CustomJSONDecoder().decode([HistoricData].self, from: data) else {
            throw ApiError.parseError
        }
        
        let dataResponse = historicalData.map { HistoricDataResponse($0) }
        try await localDataSource.save(dataResponse)
        
        return dataResponse

    }
    
    func fetchLiveData() async throws -> LiveDataResponse {
        let data: Data = try await remoteDataSource.fetchData(url: Contants.liveDataUrl)
        
        guard let liveData = try? CustomJSONDecoder().decode(LiveData.self, from: data) else {
            throw ApiError.parseError
        }
        
        return LiveDataResponse(liveData)
    }
}
