//
//  ViewController.swift
//  Crossword2
//
//  Created by Joey Liao on 4/16/19.
//  Copyright © 2019 Joey Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Q: CustomButton!
    @IBOutlet var W: CustomButton!
    @IBOutlet var E: CustomButton!
    @IBOutlet var R: CustomButton!
    @IBOutlet var T: CustomButton!
    @IBOutlet var Y: CustomButton!
    @IBOutlet var U: CustomButton!
    @IBOutlet var I: CustomButton!
    @IBOutlet var O: CustomButton!
    @IBOutlet var P: CustomButton!
    
    @IBOutlet var A: CustomButton!
    @IBOutlet var S: CustomButton!
    @IBOutlet var D: CustomButton!
    @IBOutlet var F: CustomButton!
    @IBOutlet var G: CustomButton!
    @IBOutlet var H: CustomButton!
    @IBOutlet var J: CustomButton!
    @IBOutlet var K: CustomButton!
    @IBOutlet var L: CustomButton!
    
    @IBOutlet var Z: CustomButton!
    @IBOutlet var X: CustomButton!
    @IBOutlet var C: CustomButton!
    @IBOutlet var V: CustomButton!
    @IBOutlet var B: CustomButton!
    @IBOutlet var N: CustomButton!
    @IBOutlet var M: CustomButton!

    var crosswordGrid: [[UITextField]]?
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGrid()
        fillBoard()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let button = sender as! UIButton
        print(button.titleLabel!.text!)
        activeTextField.text = button.titleLabel!.text!
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        textField.inputView = UIView() //dismiss keyboard
    }
    
    func fillBoard(){
        let items = ["A","C","I","D","I","C",".","C","H","A","C","H","I","N","G","S","U","N","O","C","O",".","A","I","W","E","I","W","E","I","P","L","A","N","A","R",".","B","E","A","N","T","O","W","N",".",".","W","E","N","D",".","B","R","I","T",".","J","A","G","A","R","O","A","R",".","R","I","O","T",".","T","I","G","E","C","A","R","N","E","G","I","E",".",".","T","A","M","E","R","T","O","D","D","L","E","S",".","S","I","R","K","A","Y",".",".",".",".","D","A","N","K",".","C","L","U","E",".",".",".",".","K","N","O","T","T","Y",".","R","E","S","T","A","T","E","K","R","O","N","E",".",".","S","I","X","T","H","M","A","N","O","I","S","E",".","A","S","A","P",".","N","E","R","D","S","W","S","W",".","S","E","T","I",".","S","O","F","A",".",".","T","H","E","C","L","O","U","D",".","L","O","A","D","E","D","O","N","A","H","U","N","C","H",".","I","N","L","I","N","E","W","A","T","E","R","S","K","I",".","M","E","L","O","D","Y"]
        var index = 0
        for row in 0...14{
            for column in 0...14{
                if items[index] == "."{
                    crosswordGrid![row][column].backgroundColor = UIColor.black
                }
                index += 1
            }
        }
    }
    
    func displayGrid(){
        //creates the buttons and array of buttons
        var subStackViewArray = [[UITextField]]()
        for _ in 1...15{
            var textFieldArray = [UITextField]()
            for _ in 1...15{
                let sampleTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                sampleTextField.text = ""
                sampleTextField.font = UIFont.systemFont(ofSize: 13)
                sampleTextField.borderStyle = UITextField.BorderStyle.line
                sampleTextField.textAlignment = .center
                sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                sampleTextField.delegate = self
                self.view.addSubview(sampleTextField)
                textFieldArray += [sampleTextField]
            }
            subStackViewArray.append(textFieldArray)
        }
        
        //put them on the board
        let subStackViewA = UIStackView(arrangedSubviews: subStackViewArray[0])
        subStackViewA.axis = .horizontal
        subStackViewA.distribution = .fillEqually
        subStackViewA.alignment = .fill
        subStackViewA.spacing = 0
        view.addSubview(subStackViewA)
        
        let subStackViewB = UIStackView(arrangedSubviews: subStackViewArray[1])
        subStackViewB.axis = .horizontal
        subStackViewB.distribution = .fillEqually
        subStackViewB.alignment = .fill
        subStackViewB.spacing = 0
        view.addSubview(subStackViewB)
        
        let subStackViewC = UIStackView(arrangedSubviews: subStackViewArray[2])
        subStackViewC.axis = .horizontal
        subStackViewC.distribution = .fillEqually
        subStackViewC.alignment = .fill
        subStackViewC.spacing = 0
        view.addSubview(subStackViewC)
        
        let subStackViewD = UIStackView(arrangedSubviews: subStackViewArray[3])
        subStackViewD.axis = .horizontal
        subStackViewD.distribution = .fillEqually
        subStackViewD.alignment = .fill
        subStackViewD.spacing = 0
        view.addSubview(subStackViewD)
        
        let subStackViewE = UIStackView(arrangedSubviews: subStackViewArray[4])
        subStackViewE.axis = .horizontal
        subStackViewE.distribution = .fillEqually
        subStackViewE.alignment = .fill
        subStackViewE.spacing = 0
        view.addSubview(subStackViewE)
        
        let subStackViewF = UIStackView(arrangedSubviews: subStackViewArray[5])
        subStackViewF.axis = .horizontal
        subStackViewF.distribution = .fillEqually
        subStackViewF.alignment = .fill
        subStackViewF.spacing = 0
        view.addSubview(subStackViewF)
        
        let subStackViewG = UIStackView(arrangedSubviews: subStackViewArray[6])
        subStackViewG.axis = .horizontal
        subStackViewG.distribution = .fillEqually
        subStackViewG.alignment = .fill
        subStackViewG.spacing = 0
        view.addSubview(subStackViewG)
        
        let subStackViewH = UIStackView(arrangedSubviews: subStackViewArray[7])
        subStackViewH.axis = .horizontal
        subStackViewH.distribution = .fillEqually
        subStackViewH.alignment = .fill
        subStackViewH.spacing = 0
        view.addSubview(subStackViewH)
        
        let subStackViewI = UIStackView(arrangedSubviews: subStackViewArray[8])
        subStackViewI.axis = .horizontal
        subStackViewI.distribution = .fillEqually
        subStackViewI.alignment = .fill
        subStackViewI.spacing = 0
        view.addSubview(subStackViewI)
        
        let subStackViewJ = UIStackView(arrangedSubviews: subStackViewArray[9])
        subStackViewJ.axis = .horizontal
        subStackViewJ.distribution = .fillEqually
        subStackViewJ.alignment = .fill
        subStackViewJ.spacing = 0
        view.addSubview(subStackViewJ)
        
        let subStackViewK = UIStackView(arrangedSubviews: subStackViewArray[10])
        subStackViewK.axis = .horizontal
        subStackViewK.distribution = .fillEqually
        subStackViewK.alignment = .fill
        subStackViewK.spacing = 0
        view.addSubview(subStackViewK)
        
        let subStackViewL = UIStackView(arrangedSubviews: subStackViewArray[11])
        subStackViewL.axis = .horizontal
        subStackViewL.distribution = .fillEqually
        subStackViewL.alignment = .fill
        subStackViewL.spacing = 0
        view.addSubview(subStackViewL)
        
        let subStackViewM = UIStackView(arrangedSubviews: subStackViewArray[12])
        subStackViewM.axis = .horizontal
        subStackViewM.distribution = .fillEqually
        subStackViewM.alignment = .fill
        subStackViewM.spacing = 0
        view.addSubview(subStackViewM)
        
        let subStackViewN = UIStackView(arrangedSubviews: subStackViewArray[13])
        subStackViewN.axis = .horizontal
        subStackViewN.distribution = .fillEqually
        subStackViewN.alignment = .fill
        subStackViewN.spacing = 0
        view.addSubview(subStackViewN)
        
        let subStackViewO = UIStackView(arrangedSubviews: subStackViewArray[14])
        subStackViewO.axis = .horizontal
        subStackViewO.distribution = .fillEqually
        subStackViewO.alignment = .fill
        subStackViewO.spacing = 0
        view.addSubview(subStackViewO)
        
        //put the newly made stack views into a stackview
        let stackView = UIStackView(arrangedSubviews: [subStackViewA,subStackViewB,subStackViewC,subStackViewD,subStackViewE,
            subStackViewF,subStackViewG,subStackViewH,subStackViewI,subStackViewJ,
            subStackViewK,subStackViewL,subStackViewM,subStackViewN,subStackViewO])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        //autolayout
        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[stackView]-15-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-100-[stackView]-250-|",
            options: NSLayoutConstraint.FormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        self.crosswordGrid = subStackViewArray
    }
}

