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
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var outletManButton: UIButton!
    @IBOutlet weak var outletWomanButton: UIButton!
    @IBOutlet weak var minutesEatTextField: UITextField!
    @IBOutlet weak var minutesDrinkTextField: UITextField!
    @IBOutlet weak var getUpDatePicker: UIDatePicker!
    @IBOutlet weak var goSleepDatePicker: UIDatePicker!
    var eatTimePicker = UIPickerView()
    var waterTimePicker = UIPickerView()
    let timeEatArray = [5, 10, 15, 20, 30, 40, 50, 60, 90, 120, 150, 180, 200, 250, 300, 350]
    let timeWaterArray = [5, 10, 15, 20, 30, 40, 50, 60, 90, 120, 150, 180, 200]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        sportTextField.delegate = self
        
        minutesEatTextField.inputView = eatTimePicker
        minutesDrinkTextField.inputView = waterTimePicker
        
        eatTimePicker.delegate = self
        eatTimePicker.dataSource = self
        waterTimePicker.delegate = self
        waterTimePicker.dataSource = self
        
        eatTimePicker.tag = 1
        waterTimePicker.tag = 2
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
        case (isEmpty: true, isInRange: false): showError(error: "Не введен введен рост")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введен рост")
        default: break
        }
        switch Keys.checkTextField(textField: weightTextField, fromNumber: 30, upToNumber: 300) {
        case (isEmpty: false, isInRange: true): Keys.weight = weightTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введен введен вес")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введен вес")
        default: break
        }
        switch Keys.checkTextField(textField: ageTextField, fromNumber: 3, upToNumber: 150) {
        case (isEmpty: false, isInRange: true): Keys.age = ageTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введен введен возраст")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введен возраст")
        default: break
        }
        switch checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton) {
        case "Error": showError(error: "Не введен пол")
        default: Keys.gender = checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton)
        }
        switch Keys.checkTextField(textField: sportTextField, fromNumber: 1, upToNumber: 1000) {
        case (isEmpty: false, isInRange: true): Keys.sport = sportTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введено занятие спортом")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введено занятие спортом")
        default: break
        }
        switch Keys.checkTextField(textField: minutesEatTextField, fromNumber: 10, upToNumber: 1000) {
        case (isEmpty: false, isInRange: true): Keys.minutesToEat = minutesEatTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введено уведомление о еде")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введено уведомление о еде")
        default: break
        }
        switch Keys.checkTextField(textField: minutesDrinkTextField, fromNumber: 2, upToNumber: 500) {
        case (isEmpty: false, isInRange: true): Keys.minutesToDrink = ageTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введено уведомление о воде")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введено уведомление о воде")
        default: break
        }

        if Keys.age != nil && Keys.gender != nil && Keys.height != nil && Keys.weight != nil && Keys.sport != nil && Keys.minutesToEat != nil && Keys.minutesToDrink != nil {
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
    func showError(error: String){
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

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return timeEatArray.count
        case 2:
            return timeWaterArray.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return "\(timeEatArray[row])"
        case 2:
            return "\(timeEatArray[row])"
        default:
            return "Data dont found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            minutesEatTextField.text = "\(timeEatArray[row])"
            minutesEatTextField.resignFirstResponder()
        case 2:
            minutesDrinkTextField.text = "\(timeWaterArray[row])"
            minutesDrinkTextField.resignFirstResponder()
        default:
            break
        }
    }
}
