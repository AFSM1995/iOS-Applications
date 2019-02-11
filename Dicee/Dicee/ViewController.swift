//
//  ViewController.swift
//  Dicee
//
//  Created by Álvaro Santillan on 11/17/18.
//  Copyright © 2018 Álvaro Santillan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // link storyboard items with code
    @IBOutlet weak var diceView1: UIImageView!
    @IBOutlet weak var diceView2: UIImageView!
    
    // Arary stores image paths index 0 = image 1 etc
    let  diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
    }
    
    // Create two int values
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    
    // Link storyboard button with code. roll button pressed is triger
    @IBAction func rollButonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    
    // calls updateDiceImages ie change dice images to random when phone is saken.
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    // Create function that chages dice images
    func updateDiceImages() {
        // Update the int veriavles defined above to a random number 0-5
        randomDiceIndex1 = Int.random(in: 0 ... 5)
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        
        // Use randome numbers to pick an image from diceArray
        diceView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }

}
