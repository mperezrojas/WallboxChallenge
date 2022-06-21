//
//  HistoricDataResponse.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

struct HistoricDataResponse: Equatable {
    let gridActivePower: Double
    let pvActivePower: Double
    let quasarsActivePower: Double
}

extension HistoricDataResponse {
    init(_ data: HistoricData) {
        self.gridActivePower = data.gridActivePower
        self.pvActivePower = data.pvActivePower
        self.quasarsActivePower = data.quasarsActivePower
    }
}
