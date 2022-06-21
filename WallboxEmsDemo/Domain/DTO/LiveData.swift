//
//  LiveData.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

struct LiveData: Codable {
    let solarPower: Double
    let quasarsPower: Double
    let gridPower: Double
    let buildingDemand: Double
    let systemSoc: Double
    let totalEnergy: Double
    let currentEnergy: Double
}
