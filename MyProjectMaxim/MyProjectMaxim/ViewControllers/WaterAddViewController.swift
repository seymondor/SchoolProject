//
//  WaterAddViewController.swift
//  MyProjectMaxim
//
//  Created by Максим on 31.01.2024.
//

import Foundation
import UIKit
class WaterAddViewController : UIViewController {
    
    @IBOutlet weak var addWaterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWaterTextField.delegate = self
    }
}
extension WaterAddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedcharacters = "0123456789"
        let allowedcharacterSet = CharacterSet(charactersIn: allowedcharacters)
        let typedCharactersetIn = CharacterSet(charactersIn: string)
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        return allowedcharacterSet.isSuperset(of: typedCharactersetIn)
    }
}
