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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFoodTextField.delegate = self
    }
    
    @IBAction func add100KkalButton(_ sender: Any) {
        addAmountVariable = 100
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @IBAction func add500KkalButton(_ sender: Any) {
        addAmountVariable = 500
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @IBAction func add1000KkalButton(_ sender: Any) {
        addAmountVariable = 1000
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @IBAction func addCustomAmount(_ sender: Any) {
        if addFoodTextField.text != "" {
            let foodCustomKkal = addFoodTextField.text
            addAmountVariable = Int(foodCustomKkal ?? "" ) ?? 0
            NotificationCenter.default.post(name: .reload, object: nil)
        } else {
            showAlert(error: "Не введёно количество еды")
        }
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
