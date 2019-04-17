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
        let vc = segue.destination as? BoardViewController
        if segue.identifier == "dynamicSegue"{
            vc!.mode = "dynamic"
        }
        else if segue.identifier == "presetSegue"{
            vc!.mode = "preset"
        }
    }
}
