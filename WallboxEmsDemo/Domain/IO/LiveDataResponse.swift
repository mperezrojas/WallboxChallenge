//
//  LiveDataResponse.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import Foundation

struct LiveDataResponse: Equatable {
    let solarPower: String
    let quasarsPower: String
    let gridPower: String
    let buildingDemand: String
    let solarPowerPercent: String
    let quasarPowerPercent: String
    let gridPowerPercent: String
}
extension LiveDataResponse {
    init(_ liveData: LiveData) {
        self.solarPower = "\(liveData.solarPower.cleanValue) KW"
        self.quasarsPower = "\(liveData.quasarsPower.cleanValue) KW"
        self.gridPower = "\(liveData.gridPower.cleanValue) KW"
        self.buildingDemand = "\(liveData.buildingDemand.cleanValue) KW"
        self.solarPowerPercent = getPercent(num1: liveData.solarPower, num2: liveData.buildingDemand)
        self.quasarPowerPercent = getPercent(num1: (liveData.quasarsPower * -1), num2: liveData.buildingDemand)
        self.gridPowerPercent = getPercent(num1: liveData.gridPower, num2: liveData.buildingDemand)
    }
}

extension LiveDataResponse {
    static func defaultLiveData() -> LiveDataResponse {
        return LiveDataResponse(solarPower: "0 KW", quasarsPower: "0 KW", gridPower: "0 KW", buildingDemand: "0 KW", solarPowerPercent: "0%", quasarPowerPercent: "0%", gridPowerPercent: "0%")
    }
}
