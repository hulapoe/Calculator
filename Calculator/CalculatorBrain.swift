//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by RAHUL CHAUDHARY on 7/23/17.
//  Copyright © 2017 hulapoe. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator;
        }
    }
    
    struct BinaryFunctionOperand {
        var firstOperand: Double
        var binaryFunction: (Double,Double) -> Double
        
        func performOperation(with secondOperand: Double) -> Double {
            return binaryFunction(firstOperand,secondOperand)
        }
        
    }
    
    var binaryFunctionOperand: BinaryFunctionOperand?
    
    enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation({-$0}),
        "×": Operation.binaryOperation({$0*$1}),
        "÷": Operation.binaryOperation({$0/$1}),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "=": Operation.equals
    ]
    
    
    mutating func setOperand(_ operand: Double ) {
        accumulator = operand
    }
    
    mutating func performOperation(_ symbol: String ) {
        
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator!)
            case .binaryOperation(let binaryFunction):
                binaryFunctionOperand = BinaryFunctionOperand(firstOperand: accumulator!, binaryFunction: binaryFunction)
            case .equals:
                if binaryFunctionOperand != nil && accumulator != nil {
                    accumulator = binaryFunctionOperand!.performOperation(with: accumulator!)
                }
            }
        }
    }
}
