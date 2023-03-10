//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by sglee237 on 2023/01/25.
//

import Foundation

func changeSign(operand: Double)->Double {
    return -operand
}

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorModel: ObservableObject {
    
    @Published var displayValue:String = "0"
    
    private let buttonCodeVertical: [[String]] = [
        ["C", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    private let buttonCodeHorizontal: [[String]] = [
        ["(",   ")",    "mc",   "m+",   "m-",   "mr",   "C",    "±",    "%",    "÷"],
        ["2nd", "x²",   "x³",   "xʸ",   "eˣ",   "10ˣ",  "7",    "8",    "9",    "×"],
        ["√x",  "2/x",  "3/x",  "y/x",  "ln",   "log10","4",    "5",    "6",    "−"],
        ["x!",  "sin",  "cos",  "tan",  "e",    "EE",   "1",    "2",    "3",    "+"],
        ["Rad", "sinh", "cosh", "tanh", "pi",   "Rand", "0",    "0",    ".",    "="]
    ]
    
    func getButtonCodeList()->[[String]] {
        return buttonCodeVertical
    }
    
    private enum Operation {
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "±" : Operation.unaryOperation(changeSign),
        "%" : Operation.unaryOperation({$0 / 100.0}),
        "×" : Operation.binaryOperation({($0 * $1)}),
        "+" : Operation.binaryOperation({($0 + $1)}),
        "-" : Operation.binaryOperation({($0 - $1)}),
        "÷" : Operation.binaryOperation({($0 / $1)}),
/*      "×" : Operation.binaryOperation({ (op1: Double, op2: Double) -> Double in
                return op1 * op2
        }*/
        "=" : Operation.equals
    ]
    
    
    func inputToken(input:String) {
        
        if let _ = Int(input) {
            inputDigit(input: input)
        }
        else {
            if userIsInTheMiddleOfTyping, let value = Double(displayValue) {
                setOperand(operand: value)
                userIsInTheMiddleOfTyping = false
            }
            performOperation(input)
            if let value = result {
                displayValue = String(value)
            }
        }
    }
    
    private func inputDigit(input:String) {
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = displayValue
            displayValue = textCurrentlyInDisplay + input
        } else {
            displayValue = input
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private var accumulator: Double?
    
    private var userIsInTheMiddleOfTyping = false
    
    private func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingbinaryOperation()
            }
        }
    }
    
    private func performPendingbinaryOperation() {
//        pbo?.perform(with: accumulator!)
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
//            return firstOperand * secondOperand
            return function(firstOperand, secondOperand)
        }
    }
    
    private func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var result: Double? {
        get {
            return accumulator
        }
    }
    
    
}
