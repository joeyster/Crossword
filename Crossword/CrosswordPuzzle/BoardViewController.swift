//
//  ViewController.swift
//  Crossword2
//
//  Created by Joey Liao on 4/16/19.
//  Copyright © 2019 Joey Liao. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UITextFieldDelegate {
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

    @IBOutlet var hintsLabel: UILabel!
    @IBOutlet var orientationButton: CustomButton!
    
    var highlightedWord: String?
    var mode: String?
    var newBoard = true
    var orientationMode = "across"
    var boardStackvView: UIStackView?
    var crosswordGrid: [[UITextField]]?
    var activeTextField = UITextField()
    var activeTag = -1
    var jsonFile: [Any] = []
    var crosswordItems: [Any] = []
    var items:[String] = []
    var wordStart: Int?
    var wordEnd: Int?
    var hintMode: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(newBoard)
        importJson()
        displayGrid()
        if newBoard{
            generateBoard()
        }
        fillBoard()
    }
    
    @IBAction func orientationButton(_ sender: Any) {
        textFieldDidEndEditing(self.activeTextField)
        if self.orientationMode == "across"{
            self.orientationMode = "down"
            self.orientationButton.setTitle("⬆⬇", for: .normal)
        }
        else if self.orientationMode == "down"{
            self.orientationMode = "across"
            self.orientationButton.setTitle("⬅➡", for: .normal)
        }
        textFieldDidBeginEditing(self.activeTextField)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        boardStackvView?.removeFromSuperview()
        displayGrid()
        generateBoard()
        fillBoard()
    }
    
    func importJson(){
        if let path = Bundle.main.path(forResource: "majortests_words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, Any>, let results = jsonResult["results"] as? [Any] {
                    self.jsonFile = results
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let button = sender as! UIButton
        self.activeTextField.text = button.titleLabel!.text!
        if self.orientationMode == "across"{
            if let nextField = activeTextField.superview?.viewWithTag(activeTag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
        else if self.orientationMode == "down"{
            if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag + 15) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func fillBoxButton(_ sender: Any) {
        self.activeTextField.text = items[activeTag].uppercased()
        if self.orientationMode == "across"{
            if let nextField = activeTextField.superview?.viewWithTag(activeTag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
        else if self.orientationMode == "down"{
            if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag + 15) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
    }
    
    func hintHandler(){
        if hintMode! {
            var answer: String = ""
            if self.orientationMode == "across" {
                for index in wordStart!...wordEnd!{
                    answer = answer + items[index]
                }
            }
            else if self.orientationMode == "down" {
                for index in stride(from: wordStart!, to: wordEnd!+1, by: 15){
                    answer = answer + items[index]
                }
            }
            
            var temp:Dictionary<String,Any>
            for index in 0...19{
                temp = crosswordItems[index] as! Dictionary<String,Any>
                if answer == temp["word"] as! String {
                    hintsLabel.text  = (temp["definition"] as! String)
                }
            }
        }
        else{
            hintsLabel.text  = "Hints disabled"
        }
    }
    
    //set bg colors + hints
    func highlightRow(){
        var temp = 0
        while items[activeTag - temp] != "-" {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag - temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            self.wordStart = activeTag-temp
            temp += 1
            if activeTag - temp < 0{ break }
        }
        temp = 0
        while items[activeTag + temp] != "-" {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag + temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            self.wordEnd = activeTag+temp
            temp += 1
            if activeTag + temp >= items.count { break }
        }
        activeTextField.backgroundColor = UIColor.yellow
    }
    
    func highlightColumn(){
        var temp = 0
        while items[activeTag - temp] != "-" {
            if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag - temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            self.wordStart = activeTag - temp
            temp += 15
            if activeTag - temp < 0 { break }
        }
        temp = 0
        while items[activeTag + temp] != "-" {
            if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag + temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            self.wordEnd = activeTag + temp
            temp += 15
            if activeTag + temp > 15*14 { break }
        }
        activeTextField.backgroundColor = UIColor.yellow
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        self.activeTag = textField.tag
        if self.orientationMode == "across"{
            highlightRow()
        }
        else if self.orientationMode == "down"{
            highlightColumn()
        }
        hintHandler()
        textField.inputView = UIView() //dismiss keyboard
    }
    
    //reset bg colours
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField.backgroundColor = UIColor.clear
        if orientationMode == "across"{
            var temp = 0
            while items[activeTag + temp] != "-" {
                if let nextField = activeTextField.superview?.viewWithTag(activeTag + temp) as? UITextField {
                    nextField.backgroundColor = UIColor.clear
                }
                temp += 1
                if activeTag + temp >= items.count { break }
            }
            temp = 0
            while items[activeTag - temp] != "-" {
                if let nextField = activeTextField.superview?.viewWithTag(activeTag - temp) as? UITextField {
                    nextField.backgroundColor = UIColor.clear
                }
                temp += 1
                if activeTag - temp < 0{ break }
            }
        }
        else if orientationMode == "down" {
            var temp = 0
            while items[activeTag + temp] != "-" {
                if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag + temp) as? UITextField {
                    nextField.backgroundColor = UIColor.clear
                }
                temp += 15
                if activeTag + temp > 15*14 { break }
            }
            temp = 0
            while items[activeTag - temp] != "-" {
                if let nextField = activeTextField.superview?.superview?.viewWithTag(activeTag - temp) as? UITextField {
                    nextField.backgroundColor = UIColor.clear
                }
                temp += 15
                if activeTag - temp < 0 { break }
            }
        }
    }
    
    func displayGrid(){
        //creates the buttons and array of buttons
        var subStackViewArray = [[UITextField]]()
        var tag = 0
        for _ in 1...15{
            var textFieldArray = [UITextField]()
            for _ in 1...15{
                let sampleTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                sampleTextField.text = ""
                sampleTextField.font = UIFont.systemFont(ofSize: 13)
                sampleTextField.borderStyle = UITextField.BorderStyle.line
                sampleTextField.textAlignment = .center
                sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                sampleTextField.tag = tag
                tag += 1
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
            withVisualFormat: "V:|-120-[stackView]-250-|",
            options: NSLayoutConstraint.FormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        self.boardStackvView = stackView
        self.crosswordGrid = subStackViewArray
    }
    
    func generateBoard(){
        var generatorArray: [String] = []
        var temp:Dictionary<String,Any>
        for _ in 1...20{
            let number = Int.random(in: 0 ... 999)
            temp = jsonFile[number] as! Dictionary<String,Any>
            self.crosswordItems.append(temp)
            generatorArray.append(temp["word"] as! String)
        }
        
        let crosswordsGenerator = CrosswordsGenerator(columns: 15, rows: 15, words: generatorArray)
        crosswordsGenerator.fillAllWords = true
        crosswordsGenerator.generate()
        self.items = crosswordsGenerator.grid!.matrix
    }
    
    func fillBoard(){
        var index = 0
        for row in 0...14{
            for column in 0...14{
                if items[index] == "-"{
                    crosswordGrid![row][column].backgroundColor = UIColor.black
                    crosswordGrid![row][column].isEnabled = false
                }
//                else{
//                    crosswordGrid![row][column].text = items[index]
//                    crosswordGrid![row][column].text = crosswordGrid![row][column].text?.uppercased()
//                }
                index += 1
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SettingsVC
        if segue.identifier == "settingsSegue"{
            vc?.hintMode = self.hintMode
            vc?.itemsHolder = self.items
            vc?.crosswordItemsHolder = self.crosswordItems
        }
    }
    
}

