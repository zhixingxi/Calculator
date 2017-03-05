//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by MQL-IT on 2017/3/5.
//  Copyright © 2017年 MIT. All rights reserved.
//  处理计算逻辑的model

import Foundation


func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain {
    private var accumulator = 0.0 // 要显示的计算结果
    
    func setOperand(operand: Double) {
        accumulator = operand
    
    }
    // 运算符表格扩展方便
    var operations: Dictionary<String, Operation > = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),// sqrt,
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({$0 * $1 }),  // ÷－＋
        "-" : Operation.BinaryOperation({$0 - $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    // 运算符类型的枚举
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    // 计算
    func performOperation(symbol: String) {
        
        guard let operation = operations[symbol] else {return}
        switch operation {
        case .Constant(let associatedConstantValue):
            accumulator = associatedConstantValue
        case .UnaryOperation(let function):
            accumulator = function(accumulator)
        case .BinaryOperation(let function):
            executePendingBinaryOperation()
            pending = PendingBinaryOperationInfo(binaryFunction: function, fistOprand: accumulator)
        case .Equals:
            executePendingBinaryOperation()
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.fistOprand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    // 存放二元计算类型和参数的结构体
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var fistOprand: Double
        
    }
    
    // 只读的计算结果
    var result: Double {
        get {
            return accumulator
        }
    }
}
