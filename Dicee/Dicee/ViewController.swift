//  ViewController.swift
//  Dicee

//  Created by Alvaro Santillan on 12/6/17.
//  Copyright © 2017 Alvaro Santillan. All rights reserved.

import UIKit // Important Library

class ViewController: UIViewController
{
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    // Array containing images
    
    @IBOutlet weak var diceimageView1: UIImageView!
    @IBOutlet weak var diceimageView2: UIImageView!
    
    override func viewDidLoad()
    // This function only gets triggered when the app boots up
    {
        super.viewDidLoad()
        updateDiceImages( )
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton)
    {
        updateDiceImages( )
    }
    
    func updateDiceImages( )
    // Function that gets used by other fuctions so that the code bellow dosent have to be copied multiple times
    // This saves on typing, cleans up code, reduces the chance of a bug
    {
    randomDiceIndex1 = Int(arc4random_uniform(6)) // Casted arc int to int
    randomDiceIndex2 = Int(arc4random_uniform(6)) // Casted arc int to int
    // Generates number between 0 and 5
    
    // print(randomDiceIndex1)
    // print(randomDiceIndex2)
    // See numbers that are generated
    
    diceimageView1.image = UIImage(named: diceArray[randomDiceIndex1])
    diceimageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    // Using random generator to generate number between 0 to 5
    // Two generators so that you get 2 random numbers
    // That number is then used by diceArray
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    // Run this code when the shake motion has ended
    {
        updateDiceImages( )
    }
}