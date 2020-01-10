//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var bill: Float?
    var tip: Float = 0.0
    var split: Int = 0
    var result: Float = 0.0
    var returnText: String = ""
    
    // Hide keyboard when user touches outside keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        if sender.tag == 0 {
            zeroPctButton.isSelected = true
            tip = 0.0
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if sender.tag == 1 {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            tip = 0.1
            twentyPctButton.isSelected = false
        } else {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tip = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        split = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        bill = Float(billTextField.text ?? "0.0")
        result = Float(String(format: "%.2f", calculate(bill: bill ?? 0.0, tip: tip, split: split)))!
    }
    
    func calculate(bill: Float, tip: Float, split: Int) -> Float {
        var userPart = bill/Float(split)
        userPart += userPart * tip
        return userPart
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // In case multiple segways
        if segue.identifier == "goToResultViewController" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.fairShare = result
            destinationVC.confirmText = "Split between \(split) people, with \(Int(tip*100))% tip."
//            destinationVC.advice = calculateBrain.getAdvice()
        }
    }
}
