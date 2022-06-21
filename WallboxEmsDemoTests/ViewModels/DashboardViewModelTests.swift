//
//  DashboardViewModelTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class DashboardViewModelTests: XCTestCase {

    var sut: DashboardViewModel!
    var fetchQuasarEnergyChargedUseCase: FetchQuasarEnergyChargedUseCaseMock!
    var fetchQuasarEnergyDischargedUseCase: FetchQuasarEnergyDischargedUseCaseMock!
    var fetchLiveDataUseCase: FetchLiveDataUseCaseMock!
    
    @MainActor
    override func setUp() {
        fetchQuasarEnergyChargedUseCase = FetchQuasarEnergyChargedUseCaseMock(gateway: DataGatewayMock())
        fetchQuasarEnergyDischargedUseCase = FetchQuasarEnergyDischargedUseCaseMock(gateway: DataGatewayMock())
        fetchLiveDataUseCase = FetchLiveDataUseCaseMock(gateway: DataGatewayMock())
        
        sut = DashboardViewModel(fetchQuasarEnergyChargedUseCase: fetchQuasarEnergyChargedUseCase, fetchQuasarEnergyDischargedUseCase: fetchQuasarEnergyDischargedUseCase, fetchLiveDataUseCase: fetchLiveDataUseCase)
    }

    override func tearDown() {
        fetchQuasarEnergyChargedUseCase = nil
        fetchQuasarEnergyDischargedUseCase = nil
        fetchLiveDataUseCase = nil
        sut = nil
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    @MainActor
    func testSendEventViewDidAppearedFetchData() async {
        await sut.send(.viewAppeared)
        fetchQuasarEnergyDischargedUseCase.verifyExecuteIsCalled(times(1))
        fetchQuasarEnergyChargedUseCase.verifyExecuteIsCalled(times(1))
        fetchLiveDataUseCase.verifyExecuteIsCalled(times(1))
    }
    
    @MainActor
    func testSendEventShowDetailTappedSetShowDetailVariableToTrue() async {
        await sut.send(.showDetailTapped)
        XCTAssertTrue(sut.showDetailView)
    }
    
    @MainActor
    func testSendEventViewDidAppearedSetQuasarTotalEnergyCharged() async {
        await sut.send(.viewAppeared)
        XCTAssertEqual(sut.quasarTotalEnergyCharged, "100 KW")
    }
    
    @MainActor
    func testFetchQuasarEnergyChargedUseCaseErrorSetViewError() async {
        fetchQuasarEnergyChargedUseCase.throwError = true
        
        await sut.send(.viewAppeared)
        XCTAssertTrue(sut.viewError.show)
        XCTAssertEqual(sut.viewError.title, "Failed to fetch Quasar Charged")
    }
    
    @MainActor
    func testSendEventViewDidAppearedSetQuasarTotalEnergyDischarged() async {
        await sut.send(.viewAppeared)
        XCTAssertEqual(sut.quasarTotalEnergyDischarged, "200 KW")
    }
    
    @MainActor
    func testFetchQuasarEnergyDischargedUseCaseErrorSetViewError() async {
        fetchQuasarEnergyDischargedUseCase.throwError = true
        
        await sut.send(.viewAppeared)
        XCTAssertTrue(sut.viewError.show)
        XCTAssertEqual(sut.viewError.title, "Failed to fetch Quasar Discharged")
    }
    
    @MainActor
    func testSendEventViewDidAppearedSetLiveData() async {
        await sut.send(.viewAppeared)
        XCTAssertEqual(sut.liveData, LiveDataResponse.mock())
    }
    
    @MainActor
    func testFetchLiveDataUseCaseErrorSetViewError() async {
        fetchLiveDataUseCase.returnError = true
        
        await sut.send(.viewAppeared)
        XCTAssertTrue(sut.viewError.show)
        XCTAssertEqual(sut.viewError.title, "Failed to fetch Live Data")
    }
}

class FetchQuasarEnergyChargedUseCaseMock: FetchQuasarEnergyChargedUseCase {
    
    var timesCalled = 0
    var throwError = false
    
    override func execute() async throws -> String {
        timesCalled += 1
        
        if throwError {
            throw TestError.generic
        }
        
        return "100"
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}

class FetchQuasarEnergyDischargedUseCaseMock: FetchQuasarEnergyDischargedUseCase {
    
    var timesCalled = 0
    var throwError = false
    
    override func execute() async throws -> String {
        timesCalled += 1
        
        if throwError {
            throw TestError.generic
        }
        
        return "200"
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}

class FetchLiveDataUseCaseMock: FetchLiveDataUseCase {
    var timesCalled = 0
    var returnError = false
    
    override func execute() async throws -> LiveDataResponse {
        timesCalled += 1
        
        if returnError {
            throw TestError.generic
        }
        
        return LiveDataResponse.mock()
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}

