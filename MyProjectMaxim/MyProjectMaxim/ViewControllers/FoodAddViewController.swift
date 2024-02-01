//
//  FoodAddViewController.swift
//  MyProjectMaxim
//
//  Created by Максим on 31.01.2024.
//

import Foundation
import UIKit
class FoodAddViewController : UIViewController {
    @IBOutlet weak var addFoodTextField: UITextField!
    @IBAction func addCustomAmount(_ sender: Any) {
        if addFoodTextField.text != "" {
            Keys.usedKkal = Keys.usedKkal + Int(addFoodTextField.text!)!

        } else {
            showAlert(error: "Не введёно количество воды")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addFoodTextField.delegate = self
    }
    func showAlert(error: String){
        let alert = UIAlertController(title: "Ошибка", message: "\(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }

}

extension FoodAddViewController: UITextFieldDelegate {
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
