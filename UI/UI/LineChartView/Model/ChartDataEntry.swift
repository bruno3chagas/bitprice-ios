//
//  ChartDataEntry.swift
//  UI
//
//  Created by mauricio.marques on 12/05/21.
//

import Foundation

public struct ChartDataEntry {
    let xAxis: Double
    let yAxis: Double
    
    public init(xAxis: Double, yAxis: Double) {
        self.xAxis = xAxis
        self.yAxis = yAxis
    }
}
