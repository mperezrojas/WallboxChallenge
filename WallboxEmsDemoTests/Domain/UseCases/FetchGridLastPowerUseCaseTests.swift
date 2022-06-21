//
//  FetchGridLastPowerUseCaseTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 30/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class FetchGridLastPowerUseCaseTests: XCTestCase {
    var sut: FetchGridLastPowerUseCase!
    var gateway:DataGatewayMock!

    @MainActor
    override func setUp() {
        gateway = DataGatewayMock()
        sut = FetchGridLastPowerUseCase(gateway: gateway)
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
    
    func testExecuteReturnThrow() async {
        gateway.responseValue = [HistoricDataResponse(gridActivePower: 10.0, pvActivePower: 0.0, quasarsActivePower: 0.0), HistoricDataResponse(gridActivePower: 10.0, pvActivePower: 0.0, quasarsActivePower: 0.0), HistoricDataResponse(gridActivePower: -10.0, pvActivePower: 0.0, quasarsActivePower: 0.0)]
        
        let response = try? await sut.execute()
        XCTAssertEqual(response, [10, 10, -10])
    }
}

