//
//  ViewController.swift
//  Crossword2
//
//  Created by Joey Liao on 4/16/19.
//  Copyright © 2019 Joey Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let items = ["A","E","F",".",".","R","A","J","A","H",".","A","T","T","A","C","L","O","T",".","A","N","A","M","E",".","S","H","O","P","T","A","R","E",".","M","I","N","E","R",".","T","E","N","T","I","N","A","N","E",".","S","U","N","B","E","A","M","S",".",".","D","U","S","T","S",".","A","D","A","G","I","O",".",".",".",".","L","E","A","N","E","R",".","L","A","R","R","U","P","P","A","D",".","S","A","T","Y","R",".","D","E","N","S","E","A","L","L","A",".","P","A","T","E","R",".","S","I","N","E","R","I","A","N","T",".","T","H","E","I","R",".","N","A","P","C","A","N","N","O","T",".","E","D","G","I","N","G",".",".",".",".","G","O","T","O","F","F",".","A","L","I","A","S",".",".","A","S","T","E","R","O","I","D",".","E","L","F","I","N","A","N","Y","A",".","E","R","R","O","L",".","E","T","N","A","D","O","N","T",".","R","E","S","T","E",".","S","E","C","T","S","N","E","E",".","O","S","T","E","O",".",".","R","E","O"
    ]
    
    let gridnums = [1,2,3,0,0,4,5,6,7,8,0,9,10,11,12,13,0,0,14,0,15,0,0,0,0,0,16,0,0,0,17,0,0,0,0,18,0,0,0,0,0,19,0,0,0,20,0,0,0,21,0,22,0,0,0,23,0,0,0,0,0,24,0,0,0,25,0,26,0,0,0,0,0,0,0,0,0,27,0,0,0,28,0,0,29,0,0,0,30,31,32,33,0,0,34,0,0,0,35,0,36,0,0,0,0,37,0,0,38,0,39,0,0,0,40,0,41,0,0,0,42,0,0,0,43,0,44,0,0,0,45,0,46,0,0,47,0,0,0,0,48,0,49,0,0,0,50,0,0,0,0,0,51,0,0,0,52,0,0,53,0,0,0,54,0,0,55,0,0,0,0,0,0,56,0,57,0,0,0,58,59,0,0,0,0,60,0,0,0,61,0,62,0,0,0,63,0,0,0,0,64,0,0,0,0,0,65,0,0,0,66,0,0,0,0,67,0,0,0,0,0,0,68,0,0
    ]
    
    let acrossHints = ["s1. Pershing's men in Eur.","s4. Hindu noble","s9. \"___ boy!\"","s13. Coagulate","s15. \"What's in ___?\"","s16. Boutique","s17. Vetch","s18. Clementine's dad","s19. Campsite need","s20. Ridiculous","s22. Rays of light","s24. Does a household chore","s26. Slow movement in music","s27. Point in horseshoes","s29. Whale","s32. Tramp along","s34. Lecher","s36. Thick","s37. ___ breve","s39. Nero's father","s41. Angle ratio","s42. Laughing","s44. Churchill's \"___ Finest Hour\"","s46. Aspect of velvet","s47. Is unable","s49. Trim","s51. Escaped punishment","s53. Kind of writ","s55. Minor planet","s57. Puckish","s59. Chekhov heroine","s60. Little Lord Fauntleroy","s62. Volcano in Sicily","s63. Common contraction","s64. Remainder, in Marseille","s65. Faction","s66. Koko's weapon","s67. Bone: Comb. form","s68. Culprit, in Calabria"]
    
    let downHints = ["s1. First of five in \"Hamlet\"","s2. Klipspringer's big cousin","s3. Words from a New Year's song","s4. Butter","s5. Witch birds","s6. Time for resolutions","s7. Revise","s8. Book about plants","s9. Fred and Adele","s10. Celebrant's time for sorrow","s11. Gobs","s12. Appropriate","s14. Past or future","s21. Greek letters","s23. Mild oath, old style","s25. Kind of dragon","s28. French state","s30. Annapolis abbr.","s31. Hen's first word","s32. Open space in Paris","s33. Inter ___","s35. Tall grass","s38. Add footnotes","s40. Latvian city","s43. Carry a burden","s45. Get under one's skin","s48. Bullfighter","s50. McKinley's Ohio birthplace","s52. Golfers' warnings","s54. Because","s55. Soon","s56. Show senility","s58. Western alliance: Abbr.","s59. Some are classified","s61. Zodiac sign"]
    
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
    var crosswordGrid: [[UITextField]]?
    var activeTextField = UITextField()
    var activeTag = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGrid()
        fillBoard()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let button = sender as! UIButton
        activeTextField.text = button.titleLabel!.text!
        if let nextField = activeTextField.superview?.viewWithTag(activeTag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
    }
    
    //set bg colors + hints
    func highlightRow(){
        var temp = 0
        while items[activeTag + temp] != "." {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag + temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            temp += 1
            if activeTag + temp >= items.count { break }
        }
        temp = 0
        while items[activeTag - temp] != "." {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag - temp) as? UITextField {
                nextField.backgroundColor = UIColor(red: 255/255, green: 243/255, blue: 159/255, alpha: 1)
            }
            temp += 1
            for hint in acrossHints{
                if hint.contains("s"+String(gridnums[activeTag - temp + 1])+"."){
                    let startOfHint = hint.firstIndex(of: " ")!
                    let fullHint = hint[startOfHint...]
                    hintsLabel.text = String(fullHint)
                }
            }
            if activeTag - temp < 0{ break }
        }
        activeTextField.backgroundColor = UIColor.yellow
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        self.activeTag = textField.tag
        highlightRow()
        textField.inputView = UIView() //dismiss keyboard
    }
    
    //reset bg colours
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField.backgroundColor = UIColor.clear
        var temp = 0
        while items[activeTag + temp] != "." {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag + temp) as? UITextField {
                nextField.backgroundColor = UIColor.clear
            }
            temp += 1
            if activeTag + temp >= items.count { break }
        }
        temp = 0
        while items[activeTag - temp] != "." {
            if let nextField = activeTextField.superview?.viewWithTag(activeTag - temp) as? UITextField {
                nextField.backgroundColor = UIColor.clear
            }
            temp += 1
            if activeTag - temp < 0{ break }
        }
    }
    
    func fillBoard(){
        var index = 0
        for row in 0...14{
            for column in 0...14{
                if items[index] == "."{
                    crosswordGrid![row][column].backgroundColor = UIColor.black
                    crosswordGrid![row][column].isEnabled = false
                }
                else{
                    crosswordGrid![row][column].text = items[index]
                }
                index += 1
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
            withVisualFormat: "V:|-100-[stackView]-250-|",
            options: NSLayoutConstraint.FormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        self.crosswordGrid = subStackViewArray
    }
}

