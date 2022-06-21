//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 이혜빈 on 2022/06/22.
//  Copyright © 2022 swiftPractice. All rights reserved.
//

import Foundation

class CalculatorBrain {
    var accumulator: Double = 0.0
    private var result: Double = 0.0
    
    //누군가가 operand(피연산숫자)를 주면 operand로 들어오는 값으로 accumulator를 다시 set
    func setOperand(operand: Double) {
        accumulator = operand
        print("input value =\(accumulator)")
    }
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
   
    private var operations: Dictionary<String, Operation> = [
        "AC": Operation.Constant(0.0),
        "π": Operation.Constant(.pi),
        "+/-": Operation.UnaryOperation({$0 * (-1)}),
        "X": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    //이항 연산에서 왼쪽 항(firstOperand) 찾기
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double // 이항함수
        var firstOperand: Double // 이항함수의 첫번째 피연산자를 추적
    }
    
    
    
}

