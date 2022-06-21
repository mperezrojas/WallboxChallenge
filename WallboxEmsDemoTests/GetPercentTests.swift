//
//  GetPercentTests.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 30/3/22.
//

import XCTest
@testable import WallboxEmsDemo

class GetPercentTests: XCTestCase {

    func testGetPercentFuncion() {
        XCTAssertEqual(getPercent(num1: 10, num2: 10), "100 %")
        XCTAssertEqual(getPercent(num1: 20, num2: 100), "20 %")
        XCTAssertEqual(getPercent(num1: 40, num2: 200), "20 %")
        XCTAssertEqual(getPercent(num1: 100, num2: 100), "100 %")
        XCTAssertEqual(getPercent(num1: 20, num2: 30), "66.67 %")
        XCTAssertEqual(getPercent(num1: 60, num2: 90), "66.67 %")
        XCTAssertEqual(getPercent(num1: 90, num2: 120), "75 %")
        XCTAssertEqual(getPercent(num1: 50, num2: 70), "71.43 %")
    }

}
