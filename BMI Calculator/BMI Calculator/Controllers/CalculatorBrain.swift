//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Álvaro Santillan on 1/7/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    mutating func calculateBMIValue(height: Float, weight: Float) {
        let BMIValue = weight/pow(height, 2)
        var advice: String
        var color: UIColor
        
        if BMIValue < 18.5 {
            advice = "Eat more pies"
            color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        } else if BMIValue < 24.9 {
            advice = "Fit as a fiddle"
            color = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        } else {
            advice = "Eat less pies"
            color = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        bmi = BMI(value: BMIValue, advice: advice, color: color)
    }
    
    func getBMIValue() -> Float {
        return bmi?.value ?? 0.0
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No Advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
