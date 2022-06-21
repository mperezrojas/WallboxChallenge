//
//  FetchQuasarEnergyChargedUseCaseTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class FetchQuasarEnergyChargedUseCaseTests: XCTestCase {

    var sut: FetchQuasarEnergyChargedUseCase!
    var gateway:DataGatewayMock!

    @MainActor
    override func setUp() {
        gateway = DataGatewayMock()
        sut = FetchQuasarEnergyChargedUseCase(gateway: gateway)
    }

    override func tearDown() {
        gateway = nil
        sut = nil
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testExecuteThrowingErrorIfGatewayFailedToFetchData() async {
        gateway.throwError = true
        do {
            _ = try await sut.execute()
        }
        catch {
            XCTAssertEqual(error as? TestError, .generic)
        }
    }
    
    func testExecuteMethodSumTwoValues() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "20")
    }
    
    func testExecuteMethodSumOneValues() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "30")
    }
    
    func testExecuteMethodSumThreeValues() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 30.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "90")
    }
    
    func testExecuteMethodNotSumAnyValue() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "0")
    }
}

class DataGatewayMock: DataGateway {
    
    var throwError = false
    
    var responseValue: [HistoricDataResponse] = []
    
    func fetchHistoricData() async throws -> [HistoricDataResponse] {
        
        if throwError {
            throw TestError.generic
        }

        return responseValue
    }
    
    func fetchLiveData() async throws -> LiveDataResponse {
        return LiveDataResponse.mock()
    }
}
