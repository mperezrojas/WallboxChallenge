//
//  FetchSolarLastPowerUseCase.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class FetchSolarLastPowerUseCase {
    let gateway: DataGateway
    
    init(gateway: DataGateway) {
        self.gateway = gateway
    }
    
    func execute() async throws -> [Double] {
        let historicData = try await gateway.fetchHistoricData()
        
        return Array(historicData.suffix(30)).map({
            $0.pvActivePower
        })
    }
}
