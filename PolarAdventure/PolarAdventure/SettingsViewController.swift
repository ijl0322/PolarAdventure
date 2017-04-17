//
//  SettingsViewController.swift
//  PolarAdventure
//
//  Created by Isabel  Lee on 16/04/2017.
//  Copyright © 2017 isabeljlee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var readToMeSwitch: UISwitch!
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "readToMe")
        } else {
            UserDefaults.standard.set(false, forKey: "readToMe")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readToMeSwitch.setOn(false, animated: true)

        if let readToMe = UserDefaults.standard.object(forKey: "readToMe") {
            print("readtome option: \(readToMe)")
            if readToMe as! Bool{
                readToMeSwitch.setOn(true, animated: true)
            }
        }
    }

}
