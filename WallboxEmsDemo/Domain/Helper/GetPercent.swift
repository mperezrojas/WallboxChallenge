//
//  GetPercent.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 30/3/22.
//

import Foundation

func getPercent(num1: Double, num2: Double) -> String {
    return "\(((num1/num2)*100).cleanValue) %"
}
