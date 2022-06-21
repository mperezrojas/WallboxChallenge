//
//  DataRepositoryTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class DataRepositoryTests: XCTestCase {

    var sut: DataRepository!
    var remoteDataSource: BackendMock!
    var localDataSource: LocalStorage!

    @MainActor
    override func setUp() {
        remoteDataSource = BackendMock()
        localDataSource = LocalStorage()
        sut = DataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
    }

    override func tearDown() {
        remoteDataSource = nil
        localDataSource = nil
        sut = nil
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchHistoricDataFromLocalSuccess() async {
        let data = try? await sut.fetchHistoricData()
        XCTAssertEqual(data, [HistoricDataResponse.mock()])
    }
    
    func testFetchHistoricDataFromLocalFailAndFetchFromRemote() async {
        localDataSource.throwError = true
        
        let _ = try? await sut.fetchHistoricData()
        
        remoteDataSource.verifyFetchDataIsCalled(times(1))
        remoteDataSource.verifyUrl(url: Contants.historicDataUrl)
    }
    
    func testFetchHistoricDataFromRemoteParseDataAndSaveInLocal() async {
        localDataSource.throwError = true
        
        let response = try? await sut.fetchHistoricData()
        
        remoteDataSource.verifyFetchDataIsCalled(times(1))
        localDataSource.verifySaveIsCalled(times(1))
        XCTAssertEqual(response, [HistoricDataResponse.mock()])
    }
    
    func testFetchLiveDataCallsToRemote() async {
        let _ = try? await sut.fetchLiveData()
        
        remoteDataSource.verifyFetchDataIsCalled(times(1))
    }
    
    func testFetchHistoricDataUrl() async {
        localDataSource.throwError = true
        
        let _ = try? await sut.fetchHistoricData()
        
        remoteDataSource.verifyUrl(url: Contants.historicDataUrl)
    }
    
    func testFetchLiveDataUrl() async {
        _ = try? await sut.fetchLiveData()
        
        remoteDataSource.verifyUrl(url: Contants.liveDataUrl)
    }
}

class BackendMock: ApiClient {
    var timesCalled = 0
    
    var url: String = ""
    
    func fetchData<T>(url: String) async throws -> T {
        timesCalled += 1
        
        self.url = url
        
        let json = """
        [{"building_active_power": 40.47342857142857, "grid_active_power": 10, "pv_active_power": 20, "quasars_active_power": 30, "timestamp": "2021-09-26T22:01:00+00:00"}]
        """
        
        return Data(json.utf8) as! T
    }
    
    func verifyFetchDataIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Fetch Data Called", file: file, line: line)
    }
    
    func verifyUrl(url: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(self.url, url, "URL", file: file, line: line)
    }
    
}

class LocalStorage: DataStorage {
    var timesCalled = 0
    var throwError = false
    
    func save<T>(_ obj: T) async throws {
        timesCalled += 1
    }
    
    func fetch<T>() async throws -> T {
        if throwError {
            throw TestError.generic
        }
        
        return [HistoricDataResponse.mock()] as! T
    }
    
    func verifySaveIsCalled(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(timesCalled), "Save Called", file: file, line: line)
    }

}
