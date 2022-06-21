//
//  LiveDataResponse+Test.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation
@testable import WallboxEmsDemo

extension LiveDataResponse {
    static func mock() -> LiveDataResponse {
        return LiveDataResponse(solarPower: "-30", quasarsPower: "-10", gridPower: "-20", buildingDemand: "-40", solarPowerPercent: "10%", quasarPowerPercent: "20%", gridPowerPercent: "70%")
    }
}
