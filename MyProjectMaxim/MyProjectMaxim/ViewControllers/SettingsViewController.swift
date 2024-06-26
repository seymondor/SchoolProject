//
//  SettingsViewController.swift
//  MyProjectMaxim
//
//  Created by Максим on 25.01.2024.
//

import Foundation
import UIKit
import UserNotifications

class SettingViewController: UIViewController {
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var outletManButton: UIButton!
    @IBOutlet weak var outletWomanButton: UIButton!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var getUpDatePicker: UIDatePicker!
    @IBOutlet weak var goSleepDatePicker: UIDatePicker!
    var foodNotificationID = 1
    var waterNotificationID = 1
    let timeEatArray = [10, 15, 20, 30, 40, 50, 60, 90, 120, 150, 180, 200, 250, 300, 350]
    let timeWaterArray = [5, 10, 15, 20, 30, 40, 50, 60, 90, 120, 150, 180, 200]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        setupTextFields()
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
            print("tapped")
            view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTextFieldTexts()
        switch Keys.gender {
        case "Man": outletManButton.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
        default: outletWomanButton.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switch Keys.gender {
        case "Man": outletManButton.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1); outletWomanButton.layer.borderColor = #colorLiteral(red: 0.6074405909, green: 0.8557563424, blue: 0.8065341115, alpha: 1)
        default: outletWomanButton.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1); outletManButton.layer.borderColor = #colorLiteral(red: 0.6074405909, green: 0.8557563424, blue: 0.8065341115, alpha: 1)
        }
    }
    
    @IBAction func manButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: outletWomanButton)
    }
    
    @IBAction func womanButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: outletManButton)
    }
    
    @IBAction func calculateStandartsButton(_ sender: Any) {
        if checkAllTextFields() == true {
            Keys.calculateStandarts()
            waterTextField.text = "\(Keys.water ?? 0)"
            foodTextField.text = "\(Keys.kkal ?? 0)"
            showAlert(alert: "Прогресс сброшен. \nВаша новая норма еды: \(Keys.kkal ?? 0) ккал \nВаша новая норма воды: \(Keys.water ?? 0) мл")
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if checkAllTextFields() == true {
            showAlert(alert: "Прогресс сброшен.")
        }
    }
    
    func checkAllTextFields() -> Bool {
        var keysBeforeFood : Int? = nil
        var keysBeforeWater : Int? = nil
        
        switch Keys.checkTextField(textField: waterTextField, fromNumber: 100, upToNumber: 10000) {
        case (isEmpty: false, isInRange: true): keysBeforeWater = Keys.water; Keys.water = Int(waterTextField.text!)
        case (isEmpty: true, isInRange: true): showError(error: "Не введено количество воды")
        case(isEmpty: false, isInRange: false): showError(error: "Неверно введено количество воды")
        default: break
        }
        switch Keys.checkTextField(textField: foodTextField, fromNumber: 100, upToNumber: 10000) {
        case (isEmpty: false, isInRange: true): keysBeforeFood = Keys.kkal; Keys.kkal = Int(foodTextField.text!)
        case (isEmpty: true, isInRange: true): showError(error: "Не введено количество воды")
        case(isEmpty: false, isInRange: false): showError(error: "Неверно введено количество воды")
        default: break
        }
        switch Keys.checkTextField(textField: heightTextField, fromNumber: 50, upToNumber: 300) {
        case (isEmpty: false, isInRange: true): Keys.height = heightTextField.text
        case (isEmpty: true, isInRange: true): showError(error: "Не введен введен рост")
        case(isEmpty: false, isInRange: false): showError(error: "Неверно введен рост")
        default: break
        }
        switch Keys.checkTextField(textField: weightTextField, fromNumber: 30, upToNumber: 300) {
        case (isEmpty: false, isInRange: true): Keys.weight = weightTextField.text
        case (isEmpty: true, isInRange: true): showError(error: "Не введен введен вес")
        case(isEmpty: false, isInRange: false): showError(error: "Неверно введен вес")
        default: break
        }
        switch Keys.checkTextField(textField: ageTextField, fromNumber: 3, upToNumber: 150) {
        case (isEmpty: false, isInRange: true): Keys.age = ageTextField.text
        case (isEmpty: true, isInRange: true): showError(error: "Не введен введен возраст")
        case(isEmpty: false, isInRange: false): showError(error: "Неверно введен возраст")
        default: break
        }
        switch checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton) {
        case "": showError(error: "Не введен пол")
        default: Keys.gender = checkButtonManOrWoman(buttonMan: outletManButton, buttonWoman: outletWomanButton)
        }
        switch Keys.checkTextField(textField: sportTextField, fromNumber: 1, upToNumber: 1000) {
        case (isEmpty: false, isInRange: true): Keys.sport = sportTextField.text
        case (isEmpty: true, isInRange: false): showError(error: "Не введено занятие спортом")
        case (isEmpty: false, isInRange: false): showError(error: "Неверно введено занятие спортом")
        default: break
        }
        
        Keys.timeGetUp = formatDatePicker(sender: getUpDatePicker)
        Keys.timeGoSleep = formatDatePicker(sender: goSleepDatePicker)
        
        if Keys.age != nil && Keys.gender != nil && Keys.height != nil && Keys.weight != nil && Keys.minutesToEat != nil && Keys.minutesToDrink != nil {
            if keysBeforeFood != Keys.kkal {
                Keys.resetValueUsedKeysKkal()
            }
            if keysBeforeWater != Keys.water {
                Keys.resetValueUsedKeysWater()
            }
            
            return true
        }
        return false
    }
    
    func formatDatePicker(sender: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        return formatter.string(from: sender.date)
    }
    
    @objc func updateByTimerFood() {
        foodNotificationID += 1
        var foodNotificationIDString = "food-notification-\(foodNotificationID)"
        checkForPermissionFood(with: foodNotificationIDString)
    }
    
    @objc func updateByTimerWater() {
        waterNotificationID += 1
        var waterNotificationIDString = "water-notification-\(waterNotificationID)"
        checkForPermissionWater(with: waterNotificationIDString)
    }
    
    func checkForPermissionFood(with indentifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToEat != nil {
                            self.dispatchNotification(indentifier: indentifier,
                                                      title: "Пора поесть!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: 1)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToEat != nil {
                    self.dispatchNotification(indentifier: indentifier,
                                              title: "Пора поесть!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: 1)
                }
            default:
                return
            }
        }
    }
    
    func checkForPermissionWater(with indentifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToDrink != nil {
                            self.dispatchNotification(indentifier: indentifier,
                                                      title: "Пора попить воды!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: 1)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToDrink != nil {
                    self.dispatchNotification(indentifier: indentifier,
                                              title: "Пора попить воды!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: 1)
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification(indentifier: String, title: String, body: String, timeIntervalSec: Double) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSec, repeats: false)

        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.minute, from: Date())
        let totalCurrentMinutes = (currentHour*60) + currentMinute
        
        let keysTimeGetUpDate = formatString(dateString: Keys.timeGetUp, dateFormat: "HH:mm")
        let keysTimeGoSleepDate = formatString(dateString: Keys.timeGoSleep, dateFormat: "HH:mm")
        
        let hourGetUp = Calendar.current.component(.hour, from: keysTimeGetUpDate)
        let minuteGetUp = Calendar.current.component(.minute, from: keysTimeGetUpDate)
        let totalMinutesGetUp = (hourGetUp*60) + minuteGetUp
        
        let hourGoSleep = Calendar.current.component(.hour, from: keysTimeGoSleepDate)
        let minuteGoSleep = Calendar.current.component(.minute, from: keysTimeGoSleepDate)
        let totalMinutesGoSleep = (hourGoSleep*60) + minuteGoSleep
        
        if totalCurrentMinutes > totalMinutesGetUp && totalCurrentMinutes < totalMinutesGoSleep {
            let request = UNNotificationRequest(identifier: "\(indentifier)", content: content, trigger: trigger)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(indentifier)"])
            notificationCenter.add(request)
       }
    }
    
    func checkButtonManOrWoman(buttonMan:UIButton,buttonWoman:UIButton) -> String {
        var result = ""
        if buttonMan.layer.borderColor == #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1) {
            result = "Man"
        } else if buttonWoman.layer.borderColor ==  #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1){
            result = "Woman"
        }
        return result
    }
    
    func createFrameForButton(button: UIButton, button2: UIButton){
        if button2.layer.borderColor == #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1) {
            button2.layer.borderColor = #colorLiteral(red: 0.6074405909, green: 0.8557563424, blue: 0.8065341115, alpha: 1)
            button.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.3837626355, green: 0.6095732872, blue: 0.4453801228, alpha: 1)
        }
    }
    
    func formatString(dateString: String, dateFormat: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone =  .current
        return formatter.date(from: dateString) ?? Date()
    }
    
    func showError(error: String){
        let alert = UIAlertController(title: "Ошибка", message: "\(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
    
    func showAlert(alert: String){
        let alert = UIAlertController(title: "Внимание", message: "\(alert).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
    
    func setupTextFields() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        sportTextField.delegate = self
    }
    
    func setupTextFieldTexts() {
        waterTextField.text = "\(Keys.water ?? 0)"
        foodTextField.text = "\(Keys.kkal ?? 0)"
        heightTextField.text = Keys.height
        weightTextField.text = Keys.weight
        ageTextField.text = Keys.age
        sportTextField.text = Keys.sport
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 1, 2: return false
        default: break
        }
        let allowedcharacters = "0123456789"
        let allowedcharacterSet = CharacterSet(charactersIn: allowedcharacters)
        let typedCharactersetIn = CharacterSet(charactersIn: string)
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        return allowedcharacterSet.isSuperset(of: typedCharactersetIn)
    }
}
