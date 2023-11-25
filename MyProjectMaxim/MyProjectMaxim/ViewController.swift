//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    func checkButtonManOrWoman(buttonMan:UIButton,buttonWoman:UIButton) -> String {
        if buttonMan.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            return "Man"
        } else if buttonWoman.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            return "Woman"
        } else {
            return "Error"
        }
    }
    func createFrameForButton(button: UIButton, button2: UIButton){
        if button2.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            button2.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
            button.layer.borderColor = #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1)
        }
    }
    @IBOutlet weak var OutletManButton: UIButton!
    @IBOutlet weak var OutletWomanButton: UIButton!
    @IBAction func StartManButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: OutletWomanButton)
    }
    @IBAction func StartWomanButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: OutletManButton)
    }
    
    
    func showAlertApsent(error: String){
        let alert = UIAlertController(title: "Ошибка", message: "Не введен \(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
    func showAlertNumber(error: String){
        let alert = UIAlertController(title: "Ошибка", message: "Неверно введен \(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
    @IBOutlet weak var StartEnterWeight: UITextField!
    @IBOutlet weak var StartEnterHeight: UITextField!
    @IBOutlet weak var StartEnterAge: UITextField!
    @IBAction func StartButton(_ sender: UIButton) {
        if StartEnterHeight.text == "" {
            Keys.height = "Error"
            showAlertApsent(error: "рост")
        } else {
            var height = Int(StartEnterHeight.text!)
            if height! > 300 || height! < 50 {
                Keys.height = "Error"
                showAlertNumber(error: "рост")
            } else {
                Keys.height = StartEnterHeight.text
            }
        }
        
        if StartEnterWeight.text == "" {
            Keys.weight = "Error"
            showAlertApsent(error: "вес")
        } else {
            var weight = Int(StartEnterWeight.text!)
            if weight! > 300 || weight! < 30 {
                Keys.weight = "Error"
                showAlertNumber(error: "вес")
            } else {
                Keys.weight = StartEnterWeight.text
            }
        }
        
        if StartEnterAge.text == "" {
            Keys.age = "Error"
            showAlertApsent(error: "возраст")
        } else {
            var age = Int(StartEnterAge.text!)
            if age! > 150 || age! < 3 {
                Keys.age = "Error"
                showAlertNumber(error: "возраст")
            } else {
                Keys.age = StartEnterAge.text
            }
        }
        
        if checkButtonManOrWoman(buttonMan: OutletManButton, buttonWoman: OutletWomanButton) == "Error" {
            Keys.gender = "Error"
            showAlertApsent(error: "пол")
        } else {
            Keys.gender = checkButtonManOrWoman(buttonMan: OutletManButton, buttonWoman: OutletWomanButton)
        }
        
        if Keys.age != "Error" && Keys.gender != "Error" && Keys.height != "Error" && Keys.weight != "Error"{
            let vc = storyboard!.instantiateViewController(withIdentifier: "HomeStoryboard") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StartEnterHeight.delegate = self
        StartEnterWeight.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
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
