//
//  FetchLiveDataUseCaseTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 30/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class FetchLiveDataUseCaseTests: XCTestCase {

    var sut: FetchLiveDataUseCase!
    var gateway:DataGatewayMock!

    @MainActor
    override func setUp() {
        gateway = DataGatewayMock()
        sut = FetchLiveDataUseCase(gateway: gateway)
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
    
    func testExecuteFetchData() async {
        let response = try? await sut.execute()
        
        XCTAssertEqual(response, LiveDataResponse.mock())
    }
}
