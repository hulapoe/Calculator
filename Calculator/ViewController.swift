//
//  ViewController.swift
//  Calculator
//
//  Created by RAHUL CHAUDHARY on 7/22/17.
//  Copyright © 2017 hulapoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var inMiddleOfTyping = false;
    
    var brain = CalculatorBrain()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!;
        print("\(digit) button touched...");
        if(inMiddleOfTyping) {
            let currentDisplayText = display.text!
            display.text = currentDisplayText + digit;
        } else {
            display.text = digit;
            inMiddleOfTyping = true
        }
    }

    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        inMiddleOfTyping = false;
        
        if let mathematicalOperation = sender.currentTitle  {
            brain.setOperand(displayValue)
            brain.performOperation(mathematicalOperation)
            displayValue = brain.result!;
        }
    }
}

