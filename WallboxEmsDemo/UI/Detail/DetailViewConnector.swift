//
//  DetailViewConnector.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class DetailViewConnector {
    private let gateway: DataGateway
    
    init(gateway: DataGateway) {
        self.gateway = gateway
    }
    
    @MainActor
    func ensambledViewModel() -> DetailViewModel  {
        let fetchQuasarLastPowerUseCase = FetchQuasarLastPowerUseCase(gateway: gateway)
        let fetchSolarLastPowerUseCase = FetchSolarLastPowerUseCase(gateway: gateway)
        let fetchGridLastPowerUseCase = FetchGridLastPowerUseCase(gateway: gateway)
        
        return DetailViewModel(fetchQuasarLastPowerUseCase: fetchQuasarLastPowerUseCase, fetchSolarLastPowerUseCase: fetchSolarLastPowerUseCase, fetchGridLastPowerUseCase: fetchGridLastPowerUseCase)
    }
}
