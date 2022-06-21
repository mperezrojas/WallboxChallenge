//
//  DetailViewModelTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 30/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class DetailViewModelTests: XCTestCase {

    var sut: DetailViewModel!
    var fetchQuasarLastPowerUseCase: FetchQuasarLastPowerUseCaseMock!
    var fetchSolarLastPowerUseCase: FetchSolarLastPowerUseCaseMock!
    var fetchGridLastPowerUseCase: FetchGridLastPowerUseCaseMock!
    
    @MainActor
    override func setUp() {
        fetchQuasarLastPowerUseCase = FetchQuasarLastPowerUseCaseMock(gateway: DataGatewayMock())
        fetchSolarLastPowerUseCase = FetchSolarLastPowerUseCaseMock(gateway: DataGatewayMock())
        fetchGridLastPowerUseCase = FetchGridLastPowerUseCaseMock(gateway: DataGatewayMock())

        sut = DetailViewModel(fetchQuasarLastPowerUseCase: fetchQuasarLastPowerUseCase, fetchSolarLastPowerUseCase: fetchSolarLastPowerUseCase, fetchGridLastPowerUseCase: fetchGridLastPowerUseCase)
    }

    override func tearDown() {
        fetchQuasarLastPowerUseCase = nil
        fetchSolarLastPowerUseCase = nil
        fetchGridLastPowerUseCase = nil
        sut = nil
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    @MainActor
    func testSendEventViewAppearedCallsToFetchQuasar() async {
        await sut.send(.viewAppeared)
        
        fetchQuasarLastPowerUseCase.verifyExecuteIsCalled(times(1))
    }
    
    @MainActor
    func testSendEventQuasarTappedCallsToFetchQuasar() async {
        await sut.send(.quasarTapped)
        
        fetchQuasarLastPowerUseCase.verifyExecuteIsCalled(times(1))
    }
    
    @MainActor
    func testSendEventSolarTappedCallsToFetchQuasar() async {
        await sut.send(.solarTapped)
        
        fetchSolarLastPowerUseCase.verifyExecuteIsCalled(times(1))
    }
    
    @MainActor
    func testSendEventGridTappedCallsToFetchQuasar() async {
        await sut.send(.gridTapped)
        
        fetchGridLastPowerUseCase.verifyExecuteIsCalled(times(1))
    }
    
    @MainActor
    func testSendEventQuasarSetDataAndTitle() async {
        await sut.send(.quasarTapped)
        
        XCTAssertEqual(sut.data, [0])
        XCTAssertEqual(sut.title, "Quasar Power")
    }
    
    @MainActor
    func testSendEventQuasarReturnError() async {
        fetchQuasarLastPowerUseCase.throwError = true
        
        await sut.send(.quasarTapped)
        
        XCTAssertTrue(sut.showError)
    }
    
    @MainActor
    func testSendEventSolarSetDataAndTitle() async {
        await sut.send(.solarTapped)
        
        XCTAssertEqual(sut.data, [0])
        XCTAssertEqual(sut.title, "Solar Power")
    }
    
    @MainActor
    func testSendEventSolarReturnError() async {
        fetchSolarLastPowerUseCase.throwError = true
        
        await sut.send(.solarTapped)
        
        XCTAssertTrue(sut.showError)
    }
    
    @MainActor
    func testSendEventGridSetDataAndTitle() async {
        await sut.send(.gridTapped)
        
        XCTAssertEqual(sut.data, [0])
        XCTAssertEqual(sut.title, "Grid Power")
    }
    
    @MainActor
    func testSendEventGridReturnError() async {
        fetchGridLastPowerUseCase.throwError = true
        
        await sut.send(.gridTapped)
        
        XCTAssertTrue(sut.showError)
    }

}

class FetchQuasarLastPowerUseCaseMock: FetchQuasarLastPowerUseCase {
    var timesCalled = 0
    var throwError = false
    
    override func execute() async throws -> [Double] {
        timesCalled += 1
        
        if throwError {
            throw TestError.generic
        }
        
        return [0]
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}

class FetchSolarLastPowerUseCaseMock: FetchSolarLastPowerUseCase {
    var timesCalled = 0
    var throwError = false
    
    override func execute() async throws -> [Double] {
        timesCalled += 1
        
        if throwError {
            throw TestError.generic
        }
        
        return [0]
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}

class FetchGridLastPowerUseCaseMock: FetchGridLastPowerUseCase {
    var timesCalled = 0
    var throwError = false
    
    override func execute() async throws -> [Double] {
        timesCalled += 1
        
        if throwError {
            throw TestError.generic
        }
        
        return [0]
    }
    
    func verifyExecuteIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Execute Called", file: file, line: line)
    }
}
