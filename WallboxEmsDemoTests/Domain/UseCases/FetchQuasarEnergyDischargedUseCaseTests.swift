//
//  FetchQuasarEnergyDischargedUseCaseTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 30/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class FetchQuasarEnergyDischargedUseCaseTests: XCTestCase {

    var sut: FetchQuasarEnergyDischargedUseCase!
    var gateway:DataGatewayMock!

    @MainActor
    override func setUp() {
        gateway = DataGatewayMock()
        sut = FetchQuasarEnergyDischargedUseCase(gateway: gateway)
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
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "-20")
    }
    
    func testExecuteMethodSumOneValues() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "-30")
    }
    
    func testExecuteMethodSumThreeValues() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -30.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: -30.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "-90")
    }
    
    func testExecuteMethodNotSumAnyValue() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0), HistoricDataResponse(gridActivePower: 0.0, pvActivePower: 0.0, quasarsActivePower: 10.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, "0")
    }
}
