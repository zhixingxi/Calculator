//
//  ViewController.swift
//  Calculator
//
//  Created by MQL-IT on 2017/3/5.
//  Copyright © 2017年 MIT. All rights reserved.
//  UI层

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    

    @IBAction private func touchDigit(_ sender: UIButton) {
        
        guard let digit = sender.currentTitle else { return }
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    private var brain = CalculatorBrain()
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
        }
        userIsInTheMiddleOfTyping = false
        guard let mathematicalSymbol = sender.currentTitle else { return  }
        
        brain.performOperation(symbol: mathematicalSymbol)
        displayValue = brain.result
        
    }
    
    
    
}

