//
//  HistoricDataResponse+Test.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation
@testable import WallboxEmsDemo

extension HistoricDataResponse {
    static func mock() -> HistoricDataResponse {
        HistoricDataResponse(gridActivePower: 10, pvActivePower: 20, quasarsActivePower: 30)
    }
}
