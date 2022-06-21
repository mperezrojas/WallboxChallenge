//
//  HistoricItem.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

struct HistoricData: Codable {
    let buildingActivePower: Double
    let gridActivePower: Double
    let pvActivePower: Double
    let quasarsActivePower: Double
    let timestamp: Date
}
