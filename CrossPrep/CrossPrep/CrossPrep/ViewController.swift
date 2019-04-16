import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let rowNum = 15
    let columnNum = 15
    var items: [String] = []
    
    // MARK: - UICollectionViewDelegate protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowNum*columnNum
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MyCollectionViewCell
        
        if self.items[indexPath.item] == "."{
            cell.textField.backgroundColor = UIColor.black
            cell.borderTextField.backgroundColor = UIColor.black
            cell.textField.isEnabled = false
        }
        else{
            cell.textField.text = self.items[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    

    
    override func viewDidLoad() {
        let crosswordsGenerator = CrosswordsGenerator(columns: columnNum, rows: rowNum, words: ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker", "rat"])
        crosswordsGenerator.generate()
        self.items = crosswordsGenerator.grid!.matrix
        self.items = ["A","C","I","D","I","C",".","C","H","A","C","H","I","N","G","S","U","N","O","C","O",".","A","I","W","E","I","W","E","I","P","L","A","N","A","R",".","B","E","A","N","T","O","W","N",".",".","W","E","N","D",".","B","R","I","T",".","J","A","G","A","R","O","A","R",".","R","I","O","T",".","T","I","G","E","C","A","R","N","E","G","I","E",".",".","T","A","M","E","R","T","O","D","D","L","E","S",".","S","I","R","K","A","Y",".",".",".",".","D","A","N","K",".","C","L","U","E",".",".",".",".","K","N","O","T","T","Y",".","R","E","S","T","A","T","E","K","R","O","N","E",".",".","S","I","X","T","H","M","A","N","O","I","S","E",".","A","S","A","P",".","N","E","R","D","S","W","S","W",".","S","E","T","I",".","S","O","F","A",".",".","T","H","E","C","L","O","U","D",".","L","O","A","D","E","D","O","N","A","H","U","N","C","H",".","I","N","L","I","N","E","W","A","T","E","R","S","K","I",".","M","E","L","O","D","Y"]
//        let invisTextField = UITextField(frame: CGRect.zero)
//        self.view.addSubview(invisTextField)
//        invisTextField.becomeFirstResponder()
//        invisTextField.keyboardType = UIKeyboardType.alphabet
    }
}

