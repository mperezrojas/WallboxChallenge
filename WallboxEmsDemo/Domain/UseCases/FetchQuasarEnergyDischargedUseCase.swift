//
//  FetchQuasarEnergyDischargedUseCase.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class FetchQuasarEnergyDischargedUseCase {
    let gateway: DataGateway
    
    init(gateway: DataGateway) {
        self.gateway = gateway
    }
    
    func execute() async throws -> String {
        let historicData = try await gateway.fetchHistoricData()
        
        return historicData.filter({ $0.quasarsActivePower < 0 }).map({$0.quasarsActivePower}).reduce(.zero, +).cleanValue
    }
}
