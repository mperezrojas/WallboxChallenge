//
//  DashboardViewModel.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    
    struct DashboardError {
        var show: Bool
        var title: String
    }
    
    enum Event {
        case viewAppeared
        case showDetailTapped
    }
    
    @Published private(set) var quasarTotalEnergyCharged = "0.0 KW"
    @Published private(set) var quasarTotalEnergyDischarged = "0.0 KW"
    @Published private(set) var liveData = LiveDataResponse.defaultLiveData()
    @Published var viewError = DashboardError(show: false, title: "")
    @Published var showDetailView = false
    
    private let fetchQuasarEnergyChargedUseCase: FetchQuasarEnergyChargedUseCase
    private let fetchQuasarEnergyDischargedUseCase: FetchQuasarEnergyDischargedUseCase
    private let fetchLiveDataUseCase: FetchLiveDataUseCase
    
    init(fetchQuasarEnergyChargedUseCase: FetchQuasarEnergyChargedUseCase,
         fetchQuasarEnergyDischargedUseCase: FetchQuasarEnergyDischargedUseCase, fetchLiveDataUseCase: FetchLiveDataUseCase) {
        self.fetchQuasarEnergyChargedUseCase = fetchQuasarEnergyChargedUseCase
        self.fetchQuasarEnergyDischargedUseCase = fetchQuasarEnergyDischargedUseCase
        self.fetchLiveDataUseCase = fetchLiveDataUseCase
    }
    
    private func fetchData() async {
        await fetchQuasarEnergyCharged()
        await fetchQuasarEnergyDischarged()
        await fetchLiveData()
    }
    
    private func fetchQuasarEnergyCharged() async {
        do {
            let energy = try await fetchQuasarEnergyChargedUseCase.execute()
            quasarTotalEnergyCharged = "\(energy) KW"
        }
        catch {
            viewError = DashboardError(show: true, title: "Failed to fetch Quasar Charged")
        }
    }
    
    private func fetchQuasarEnergyDischarged() async {
        do {
            let energy = try await fetchQuasarEnergyDischargedUseCase.execute()
            quasarTotalEnergyDischarged = "\(energy) KW"
        }
        catch {
            viewError = DashboardError(show: true, title: "Failed to fetch Quasar Discharged")

        }
    }
    
    private func fetchLiveData() async {
        do {
            liveData = try await fetchLiveDataUseCase.execute()
        }
        catch {
            viewError = DashboardError(show: true, title: "Failed to fetch Live Data")
        }
    }
    
    func send(_ event: Event) async {
        switch event {
        case .viewAppeared:
            await fetchData()
        case .showDetailTapped:
            showDetailView = true
        }
    }
}
