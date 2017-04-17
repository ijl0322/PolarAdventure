//
//  ViewController.swift
//  PolarAdventure
//
//  Created by Isabel  Lee on 16/04/2017.
//  Copyright © 2017 isabeljlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Variables
    
    let bounds = Size()
    var screenWidth = 0.0
    var screenHeight = 0.0
    var penguin: Penguin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = bounds.screenWidth
        screenHeight = bounds.screenHeight
        penguin = Penguin(x: screenWidth * 0.25, y: screenHeight * 0.85)
        penguin!.addSwipe()
        self.view.addSubview(penguin!)
    }
    
    @IBAction func unwindToRVC(sender: UIStoryboardSegue) {
        print("Back at RVC")
    }
}
