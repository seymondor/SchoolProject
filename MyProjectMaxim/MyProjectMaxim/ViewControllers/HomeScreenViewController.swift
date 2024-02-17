//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit	
import BonsaiController
import UserNotifications

var addAmountVariable = 0

class HomeScreenViewController: UIViewController {
    
    var historyFoodTableView = UITableView()
    var historyWaterTableView = UITableView()
    var historyFoodArray : [HistoryFoodSlot] = []
    var historyWaterArray : [HistoryWaterSlot] = []
    
    @IBOutlet weak var CircularProgress :
        CircularProgressBar!
    
    @IBOutlet weak var backgroundOfEmojiSelectedBar: UIView!
    @IBOutlet weak var emojiSelectedBar: UIImageView!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var amountOfSomething: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLabel(notification:)), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dayChanged(notification:)), name: UIApplication.significantTimeChangeNotification, object: nil)
        
        checkForPermission()
        setupWaterHistoryTableView()
        setupFoodHistoryTableView()
        switch Keys.selectedBar {
        case "water":
            setupTableView(tableView: historyWaterTableView)
        case "food":
            setupTableView(tableView: historyFoodTableView)
        default: break
        }
        setBars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBars()
    }
    
    @IBAction func WaterChangeButton(_ sender: UIButton!) {
        switch Keys.selectedBar {
        case "water": showAlert(error: "Уже выбран счетчик воды")
        default: changeBar(to: "water"); setAlertLabel(on: Keys.selectedBar)
        }
    }
    
    @IBAction func foodChangeButton(_ sender: UIButton!) {
        switch Keys.selectedBar {
        case "food": showAlert(error: "Уже выбран счетчик еды")
        default: changeBar(to: "food"); setAlertLabel(on: Keys.selectedBar)
        }
    }
    
    @IBAction func addAmountButton(_ sender: UIButton) {
        if Keys.selectedBar == "water" {
            let waterVC = storyboard!.instantiateViewController(withIdentifier:"WaterAddVC")
            waterVC.transitioningDelegate = self
            waterVC.modalPresentationStyle = .custom
            present(waterVC, animated:true, completion: nil)
        } else {
            let foodVC = storyboard!.instantiateViewController(withIdentifier:"FoodAddVC")
            foodVC.transitioningDelegate = self
            foodVC.modalPresentationStyle = .custom
            present(foodVC, animated:true, completion: nil)
        }
    }
    
    func changeBarValue(withKey keyBar: String, fromValuePercentage: Float, toValuePercentage: Float) {
        switch keyBar {
        case "water":
            var percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(percentage))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water)) мл"
        case "food":
            var percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(percentage))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal)) ккал"
        default:
            break
        }
    }
    
    @objc func dayChanged(notification: Notification){
        Keys.resetValueUsedKeys()
        changeBarValue(withKey: "water", fromValuePercentage: 0, toValuePercentage: 0)
        changeBarValue(withKey: "food", fromValuePercentage: 0, toValuePercentage: 0)
    }
    
    func changeBar(to bar: String) {
        switch bar {
        case "water":
            historyFoodTableView.isHidden = true
            historyWaterTableView.isHidden = false
            
            setupTableView(tableView: historyWaterTableView)
            Keys.selectedBar = "water"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "drop.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: Float(percentage)/100)
        case "food":
            historyWaterTableView.isHidden = true
            historyFoodTableView.isHidden = false
            
            setupTableView(tableView: historyFoodTableView)
            Keys.selectedBar = "food"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "carrot.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6870872528, green: 0.9167618414, blue: 0.7997073189, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            let percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)

            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: Float(percentage)/100)
        default:
            break
        }
    }
    
    func getKeyFromDictionary(fromDictionary : Dictionary<String, Int>) -> String {
        for key in fromDictionary.keys {
            return key
        }
        return ""
    }
    
    func getValueFromDictionary(fromDictionary : Dictionary<String, Int>) -> Int {
        for value in fromDictionary.values {
            return value
        }
        return 0
    }
    
    @objc func reloadLabel(notification: Notification){
        switch Keys.selectedBar {
        case "food":
            let foodImageView = UIImageView()
            foodImageView.backgroundColor = .white
            foodImageView.image = UIImage(named: "carrot")
            Keys.historyFood = []
            historyFoodArray = addNewValueInArrayFood(array: historyFoodArray, value: HistoryFoodSlot(image: foodImageView, date: Date(), amount: addAmountVariable))
            
            UserDefaults.standard.removeObject(forKey: "historyFood")
            saveSlotInDefaultsFood(array: historyFoodArray)
            UserDefaults.standard.synchronize()
            
            historyFoodTableView.insertRows(at: [IndexPath(row: historyFoodArray.count - 1 , section: 0)], with: .automatic)
            historyFoodTableView.reloadData()
            
            let beforePercentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            amountOfSomething.text = "\((Int(Keys.usedKkal)) + addAmountVariable)/\(Int(Keys.kkal)) ккал"
            Keys.usedKkal = Keys.usedKkal + addAmountVariable
            let percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            percentageLabel.text = "\(Int(percentage))%"
            setAlertLabel(on: Keys.selectedBar)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(percentage)/100, from: Float(beforePercentage)/100)
        case "water":
            let waterImageView = UIImageView()
            waterImageView.backgroundColor = .white
            waterImageView.image = UIImage(named: "water")
            Keys.historyWater = []
            historyWaterArray = addNewValueInArrayWater(array: historyWaterArray, value: HistoryWaterSlot(image: waterImageView, date: Date(), amount: addAmountVariable))
            
            UserDefaults.standard.removeObject(forKey: "historyWater")
            saveSlotInDefaultsWater(array: historyWaterArray)
            UserDefaults.standard.synchronize()
            
            historyWaterTableView.insertRows(at: [IndexPath(row: historyWaterArray.count - 1 , section: 0)], with: .automatic)
            historyWaterTableView.reloadData()
            
            let beforePercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            amountOfSomething.text = "\((Int(Keys.usedWater)) + addAmountVariable)/\(Int(Keys.water)) мл"
            Keys.usedWater = Keys.usedWater + addAmountVariable
            var percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            percentageLabel.text = "\(Int(percentage))%"
            setAlertLabel(on: Keys.selectedBar)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(percentage)/100, from: Float(beforePercentage)/100)
        default:
            break
        }
    }

    func setAlertLabel(on bar: String){
        switch bar {
        case "water":
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            if percentage > 100 {
                alertLabel.text = "❗️Вы перепиваете"
                alertLabel.isHidden = false
            } else { alertLabel.isHidden = true }
        default:
            let percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            if percentage > 100 {
                alertLabel.text = "❗️Вы переедаете"
                alertLabel.isHidden = false
            } else { alertLabel.isHidden = true }
        }
    }
    
    func setupTableView(tableView : UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        historyView.addSubview(tableView)
        historyWaterTableView.tag = 1
        historyFoodTableView.tag = 2
        tableView.leftAnchor.constraint(equalTo: historyView.leftAnchor, constant: 10).isActive = true
        tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: historyView.rightAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: historyView.bottomAnchor, constant: -10).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(Cell.self, forCellReuseIdentifier: "HistorySlot")
        tableView.isHidden = false
    }
    
    func setBars() {
        switch Keys.selectedBar {
        case "water":
            changeBar(to: "water")
            setAlertLabel(on: Keys.selectedBar)
        default:
            changeBar(to: "food")
            setAlertLabel(on: Keys.selectedBar)
        }
    }
    
    func setupWaterHistoryTableView() {
        historyWaterArray = []
        if Keys.historyWater != nil {
            historyWaterArray = setArrayFromWaterKeys(array: historyWaterArray)
            historyWaterTableView.deleteRows(at: [IndexPath(row: historyWaterArray.count - 1 , section: 0)], with: .automatic)
            historyWaterTableView.reloadData()
            historyWaterArray = Array(historyWaterArray.reversed())
        }
    }
    
    func setupFoodHistoryTableView() {
        historyFoodArray = []
        if Keys.historyFood != nil {
            historyFoodArray = setArrayFromFoodKeys(array: historyFoodArray)
            historyFoodTableView.deleteRows(at: [IndexPath(row: historyFoodArray.count - 1 , section: 0)], with: .automatic)
            historyFoodTableView.reloadData()
            historyFoodArray = Array(historyFoodArray.reversed())
        }
    }
    
    func setArrayFromWaterKeys(array: [HistoryWaterSlot]) -> [HistoryWaterSlot] {
        let waterImageView = UIImageView()
        waterImageView.backgroundColor = .white
        waterImageView.image = UIImage(named: "water")
        var copyArray = array
        if Keys.historyWater != nil {
            for items in Keys.historyWater {
                print(getDateDictionary(fromDictionary: items))
                copyArray.append(HistoryWaterSlot(image: waterImageView, date: getDateDictionary(fromDictionary: items), amount: getValueDictionary(fromDictionary: items)))
            }
            copyArray = Array(copyArray.reversed())
        }
        return copyArray
    }
    
    func setArrayFromFoodKeys(array: [HistoryFoodSlot]) -> [HistoryFoodSlot] {
        let foodImageView = UIImageView()
        foodImageView.backgroundColor = .white
        foodImageView.image = UIImage(named: "carrot")
        var copyArray = array
        if Keys.historyFood != nil {
            for items in Keys.historyFood {
                print(getDateDictionary(fromDictionary: items))
                copyArray.append(HistoryFoodSlot(image: foodImageView, date: getDateDictionary(fromDictionary: items), amount: getValueDictionary(fromDictionary: items)))
            }
            copyArray = Array(copyArray.reversed())
        }
        return copyArray
    }
    
    func addNewValueInArrayFood(array: [HistoryFoodSlot], value: HistorySlot) -> [HistoryFoodSlot] {
        var copyArray = Array(array.reversed())
        copyArray.append(value as! ReversedCollection<[HistoryFoodSlot]>.Element)
        return Array(copyArray.reversed())
    }
    
    func addNewValueInArrayWater(array: [HistoryWaterSlot], value: HistorySlot) -> [HistoryWaterSlot] {
        var copyArray = Array(array.reversed())
        copyArray.append(value as! ReversedCollection<[HistoryWaterSlot]>.Element)
        return Array(copyArray.reversed())
    }

    
    func getDateDictionary(fromDictionary : Dictionary<String, Int>) -> Date {
        for key in fromDictionary.keys {
            let dateFormatter = DateFormatter()
            print(key)
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter.timeZone =  .current
            return dateFormatter.date(from: key)!
        }
        return Date()
    }
    
    func getValueDictionary(fromDictionary : [String : Int]) -> Int {
        for value in fromDictionary.values {
            return value
        }
        return 0
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow{
//                        self.dispatchNotification()
                    }
                }
            case .denied:
                return
            case .authorized:
//                self.dispatchNotification()
            default:
                return
            }
        }
    }
    
    private func dispatchNotification(indentifier: String, title: String, body: String, timeInterval: Int, isDaily: Bool) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        /// сделать ифку если попадает в временной промежуток то отпраить нотификацию :)
        
        let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [indentifier])
        notificationCenter.add(request)
    }
    
    func showAlert(error: String){
        let alert = UIAlertController(title: "Внимание", message: "\(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
}


extension HomeScreenViewController: BonsaiControllerDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 1.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (3/4)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.2), presentedViewController: presented, delegate: self)
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
    
extension HomeScreenViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return historyWaterArray.count
        case 2 :
            return historyFoodArray.count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySlot", for: indexPath) as? Cell else { fatalError() }
            if historyWaterArray[indexPath.row] != nil {
                cell.configure(slotHistory: historyWaterArray[indexPath.row])
            }
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySlot", for: indexPath) as? Cell else { fatalError() }
            if historyFoodArray[indexPath.row] != nil {
                cell.configure(slotHistory: historyFoodArray[indexPath.row])
            }
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySlot", for: indexPath)
            cell.textLabel?.text = "Error"
            return cell
        }
    }
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}
