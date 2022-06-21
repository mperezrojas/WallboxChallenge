//
//  DashboardConnector.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

class DashboardConnector {
    private let gateway: DataGateway
    
    init(gateway: DataGateway) {
        self.gateway = gateway
    }
    
    @MainActor
    func ensambledViewModel() -> DashboardViewModel  {
        let fetchQuasarEnergyChargedUseCase = FetchQuasarEnergyChargedUseCase(gateway: gateway)
        let fetchQuasarEnergyDischargedUseCase = FetchQuasarEnergyDischargedUseCase(gateway: gateway)
        let fetchLiveDataUseCase = FetchLiveDataUseCase(gateway: gateway)
        
        return DashboardViewModel(fetchQuasarEnergyChargedUseCase: fetchQuasarEnergyChargedUseCase, fetchQuasarEnergyDischargedUseCase: fetchQuasarEnergyDischargedUseCase, fetchLiveDataUseCase: fetchLiveDataUseCase)
    }
    
    @MainActor
    func configureDetailViewModel() -> DetailViewModel {
        DetailViewConnector(gateway: gateway).ensambledViewModel()
    }
}
