//
//  TestData.swift
//  WallboxEmsDemoTests
//
//  Created by Miguel Perez on 29/3/22.
//

import Foundation

func times(_ times: Int) -> (Int) -> Bool {
    return { n in
        return times == n
    }
}

enum TestError: Error {
    case generic
}
