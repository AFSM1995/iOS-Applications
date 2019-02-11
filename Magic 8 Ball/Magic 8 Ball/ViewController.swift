//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Álvaro Santillan on 11/17/18.
//  Copyright © 2018 Álvaro Santillan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    var randomBallNumber: Int = 0

    @IBOutlet weak var ballImage: UIImageView!
    
    @IBAction func askButtonPressed(_ sender: Any) {
        generateAnswer()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        generateAnswer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateAnswer()
    }
    
    func generateAnswer() {
        // Generate random number
        randomBallNumber = Int.random(in: 0 ... 4)
        
        // Use randome numbers to pick an image from diceArray
        ballImage.image = UIImage(named: ballArray[randomBallNumber])
    }
}
