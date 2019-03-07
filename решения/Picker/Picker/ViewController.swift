//
//  ViewController.swift
//  Picker
//
//  Created by REYNIKOV ANTON on 07/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    var myArr = [String]()
    var myT = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myArr = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        myT = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.movePicker), userInfo: nil, repeats: true)
    }
    @objc func movePicker()  {
            let position = Int(arc4random_uniform(89) + 10)
            picker.selectRow(position, inComponent: 0, animated: true)
            picker.showsSelectionIndicator = true
            if position == 50 || position == 72 || position == 90 || position == 35  {
                myT.invalidate()
                let alert = UIAlertController(title: "You Won!!", message: "Congratulations!!!", preferredStyle: .alert)
                let buttonOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                let playAgain = UIAlertAction(title: "Play Again!", style: .default, handler: { (action) in
                self.myT = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.movePicker), userInfo: nil, repeats: true)
                })
                alert.addAction(buttonOK)
                alert.addAction(playAgain)
                present(alert, animated: true, completion: nil)
            }
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return myArr.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: String, forComponent component: String) -> String? {
            return "\( myArr[row])"
        }
    
    }
    


