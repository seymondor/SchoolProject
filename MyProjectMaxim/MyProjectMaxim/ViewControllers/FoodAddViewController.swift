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
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    
    @IBAction func add100kkalButton(_ sender: Any) {
        addKkal(kkal: 100)
    }
    
    @IBAction func add200kkalButton(_ sender: Any) {
        addKkal(kkal: 200)
    }
    
    @IBAction func add300kkalButton(_ sender: Any) {
        addKkal(kkal: 300)
    }
    
    @IBAction func add400kkalButton(_ sender: UIButton) {
        addKkal(kkal: 400)
    }
    
    @IBAction func add500kkalButton(_ sender: UIButton) {
        addKkal(kkal: 500)
    }
    
    @IBAction func add1000kkalButton(_ sender: Any) {
        addKkal(kkal: 1000)
    }
    
    func addKkal(kkal: Int) {
        addAmountVariable = kkal
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
    
    @objc func tap(sender: UITapGestureRecognizer){
            print("tapped")
            view.endEditing(true)
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
