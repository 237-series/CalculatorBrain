//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by sglee237 on 2023/01/25.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    func performOperation(_ symbol: String) {

    }
    
    mutating func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var result: Double {
        get {
            return accumulator!
        }
    }
}
