//
//  DetailViewModel.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 28/3/22.
//

import Foundation
import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    
    enum Event {
        case viewAppeared
        case quasarTapped
        case solarTapped
        case gridTapped
    }
    
    @Published private(set) var data: [Double] = []
    @Published private(set) var title = ""
    @Published var showError = false
    
    private let fetchQuasarLastPowerUseCase: FetchQuasarLastPowerUseCase
    private let fetchSolarLastPowerUseCase: FetchSolarLastPowerUseCase
    private let fetchGridLastPowerUseCase: FetchGridLastPowerUseCase
    
    init(fetchQuasarLastPowerUseCase: FetchQuasarLastPowerUseCase, fetchSolarLastPowerUseCase: FetchSolarLastPowerUseCase, fetchGridLastPowerUseCase: FetchGridLastPowerUseCase) {
        self.fetchQuasarLastPowerUseCase = fetchQuasarLastPowerUseCase
        self.fetchSolarLastPowerUseCase = fetchSolarLastPowerUseCase
        self.fetchGridLastPowerUseCase = fetchGridLastPowerUseCase
    }
    
    private func fetchQuasarPower() async {
        do {
            data = try await fetchQuasarLastPowerUseCase.execute()
            title = "Quasar Power"
        }
        catch {
            data = []
            showError = true
        }
    }
    
    private func fetchSolarPower() async {
        do {
            data = try await fetchSolarLastPowerUseCase.execute()
            title = "Solar Power"
        }
        catch {
            data = []
            showError = true
        }
    }
    
    private func fetchGridPower() async {
        do {
            data = try await fetchGridLastPowerUseCase.execute()
            title = "Grid Power"
        }
        catch {
            data = []
            showError = true
        }
    }
    
    func send(_ event: Event) async {
        switch event {
        case .viewAppeared, .quasarTapped:
            await fetchQuasarPower()
        case .solarTapped:
            await fetchSolarPower()
        case .gridTapped:
            await fetchGridPower()
        }
    }
}
