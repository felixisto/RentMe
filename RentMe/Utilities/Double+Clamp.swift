//
//  Double+Clamp.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Foundation

extension Double {
    public func clamp(_ minValue: Double, _ maxValue: Double) -> Double {
        return min(max(self, minValue), maxValue)
    }
}
