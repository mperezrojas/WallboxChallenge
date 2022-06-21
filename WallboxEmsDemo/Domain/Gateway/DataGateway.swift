//
//  DataGateway.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

protocol DataGateway {
    func fetchHistoricData() async throws -> [HistoricDataResponse]
    func fetchLiveData() async throws -> LiveDataResponse
}
