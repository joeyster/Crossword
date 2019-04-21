//
//  ViewController.swift
//  Crossword2
//
//  Created by Joey Liao on 4/16/19.
//  Copyright © 2019 Joey Liao. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? BoardVC
        if segue.identifier == "dynamicSegue"{
            vc!.mode = "dynamic"
            let status = UserDefaults.standard.bool(forKey: "hintsBool")
            if status == true || status == false{
                vc?.hintMode = status
            }
            else{
                vc?.hintMode = true
            }
        }
            //coming soon
        else if segue.identifier == "presetSegue"{
            vc!.mode = "preset"
        }
    }
}
