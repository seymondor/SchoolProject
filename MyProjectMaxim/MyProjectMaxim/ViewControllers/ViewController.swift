//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var outletManButton: UIButton!
    @IBOutlet weak var outletWomanButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
    }
    @IBAction func manButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: outletWomanButton)
    }
    @IBAction func womanButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: outletManButton)
    }
    @IBAction func startButton(_ sender: UIButton) {
        switch Keys.checkTextField(textField: heightTextField, fromNumber: 50, upToNumber: 300) {
        case (isEmpty: false, isInRange: true): Keys.height = heightTextField.text
        case (isEmpty: true, isInRange: false): showAlert(error: "Не введен введен рост")
        case (isEmpty: false, isInRange: false): showAlert(error: "Неверно введен рост")
        default: break
        }
        switch Keys.checkTextField(textField: weightTextField, fromNumber: 30, upToNumber: 300) {
        case (isEmpty: false, isInRange: true): Keys.weight = weightTextField.text
        case (isEmpty: true, isInRange: false): showAlert(error: "Не введен введен вес")
        case (isEmpty: false, isInRange: false): showAlert(error: "Неверно введен вес")
        default: break
        }
        switch Keys.checkTextField(textField: ageTextField, fromNumber: 3, upToNumber: 150) {
        case (isEmpty: false, isInRange: true): Keys.age = ageTextField.text
        case (isEmpty: true, isInRange: false): showAlert(error: "Не введен введен возраст")
        case (isEmpty: false, isInRange: false): showAlert(error: "Неверно введен возраст")
        default: break
        }
        switch checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton) {
        case "Error": showAlert(error: "Не введен пол")
        default: Keys.gender = checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton)
        }
            
        if Keys.age != nil && Keys.gender != nil && Keys.height != nil && Keys.weight != nil {
            Keys.calculateStandarts()
            let vc = storyboard!.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    func checkButtonManOrWoman(buttonMan:UIButton, buttonWoman:UIButton) -> String {
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
    func showAlert(error: String){
        let alert = UIAlertController(title: "Ошибка", message: "\(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
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
