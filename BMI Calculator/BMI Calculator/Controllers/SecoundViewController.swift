//
//  SecoundViewController.swift
//  BMI Calculator
//
//  Created by Álvaro Santillan on 1/7/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class SecoundViewController: UIViewController {
    
    var bmi: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = String(bmi)
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.addSubview(label)
        
    }
}
