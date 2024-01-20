//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        StartEnterHeight.delegate = self
        StartEnterWeight.delegate = self
    
    }
    func checkButtonManOrWoman(buttonMan:UIButton,buttonWoman:UIButton) -> String {
        if buttonMan.layer.borderColor == #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1) {
            return "Man"
        } else if buttonWoman.layer.borderColor ==  #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1){
            return "Woman"
        } else {
            return "Error"
        }
    }
    func createFrameForButton(button: UIButton, button2: UIButton){
        if button2.layer.borderColor == #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1) {
            button2.layer.borderColor = #colorLiteral(red: 0.6074405909, green: 0.8557563424, blue: 0.8065341115, alpha: 1)
            button.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
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
    
    
    func calculateStandarts(){
        var beforeInitKkal : Int = 10 * Int(Keys.weight)!
        beforeInitKkal = beforeInitKkal + (6 * Int(Keys.height)!)
        beforeInitKkal = beforeInitKkal - (5 * Int(Keys.age)!)
        if Keys.gender == "Woman" {
            Keys.kkal = beforeInitKkal - 161
            var beforeInitWater : Double = Double(Keys.weight)! * 0.03
            beforeInitWater = (beforeInitWater + 30 * 0.6) * 100
            Keys.water = Int(beforeInitWater)
        }
        if Keys.gender == "Man" {
            Keys.kkal = beforeInitKkal + 5
            var beforeInitWater : Double = Double(Keys.weight)! * 0.04
            beforeInitWater = (beforeInitWater + 30 * 0.6) * 100
            Keys.water = Int(beforeInitWater)
        }
        print("KKAL - \(Keys.kkal ?? 0)")
        print("WATER - \(Keys.water ?? 0)")
    }
    
    
    @IBOutlet weak var StartEnterWeight: UITextField!
    @IBOutlet weak var StartEnterHeight: UITextField!
    @IBOutlet weak var StartEnterAge: UITextField!
    @IBAction func StartButton(_ sender: UIButton) {
        if StartEnterHeight.text == "" {
            Keys.height = "Error"
            showAlertApsent(error: "рост")
        } else {
            let height = Int(StartEnterHeight.text!)
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
            let weight = Int(StartEnterWeight.text!)
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
            let age = Int(StartEnterAge.text!)
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
            calculateStandarts()
            let vc = storyboard!.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
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
