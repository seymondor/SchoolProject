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
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @IBAction func add200mlButton(_ sender: Any) {
        addMl(ml: 200)
    }
    
    @IBAction func add300mlButton(_ sender: Any) {
        addMl(ml: 300)
    }
    
    @IBAction func add400mlButton(_ sender: Any) {
        addMl(ml: 400)
    }
    
    @IBAction func add500mlButton(_ sender: Any) {
        addMl(ml: 500)
    }
    
    @IBAction func add1000mlButton(_ sender: Any) {
        addMl(ml: 1000)
    }
    
    @IBAction func add1500mlButton(_ sender: Any) {
        addMl(ml: 1500)
    }
    
    @IBAction func addCustomWaterButton(_ sender: Any) {
        if addWaterTextField.text != "" {
            let waterCustomKkal = addWaterTextField.text
            addAmountVariable = Int(waterCustomKkal ?? "") ?? 0
            NotificationCenter.default.post(name: .reload, object: nil)
        } else {
            showAlert(error: "Не введёно количество воды")
        }
    }
    
    func addMl(ml: Int) {
        addAmountVariable = ml
        NotificationCenter.default.post(name: .reload, object: nil)
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
