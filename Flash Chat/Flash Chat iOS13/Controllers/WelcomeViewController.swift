//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // With Cocoa pod
        titleLabel.text = "⚡️FlashChat"
        

// Without Cocoa pod
//        titleLabel.text = ""
//        let titleText = "⚡️FlashChat"
//        var addedTime = 0.0
//
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * addedTime, repeats: false) { (Timer) in
//                self.titleLabel.text?.append(letter)
//            }
//            addedTime += 1
//        }
    }
}
