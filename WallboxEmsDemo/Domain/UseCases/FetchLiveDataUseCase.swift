//
//  FetchLiveDataUseCase.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

class FetchLiveDataUseCase {
    let gateway: DataGateway
    
    init(gateway: DataGateway) {
        self.gateway = gateway
    }
    
    func execute() async throws -> LiveDataResponse {
        return try await gateway.fetchLiveData()
    }
}
