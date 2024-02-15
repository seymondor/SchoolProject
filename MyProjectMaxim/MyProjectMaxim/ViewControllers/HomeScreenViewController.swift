//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit	
import BonsaiController
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
        historyFoodArray = setArrayFromFoodKeys(array: historyFoodArray)
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
        historyFoodArray = setArrayFromFoodKeys(array: historyFoodArray)
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
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water)) мл"
        case "food":
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal)) ккал"
        default:
            break
        }
    }
    
    func changeBar(to bar: String) {
        switch bar {
        case "water":
            historyFoodTableView.isHidden = true
            setupTableView(tableView: historyWaterTableView)
            Keys.selectedBar = "water"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "drop.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: Float(perc)/100)
        case "food":
            historyWaterTableView.isHidden = true
            setupTableView(tableView: historyFoodTableView)
            let foodImageView = UIImageView()
            foodImageView.image = UIImage(named: "carrot")
//            for items in historyFoodArray {
//                let timeMedium = getKeyFromDictionary(fromDictionary: items).suffix(8).prefix(5)
//                timeLabel.text = "\(timeMedium)"
//                let kkal = getValueFromDictionary(fromDictionary: items)
//                addAmountView.text = "\(kkal) kkal"
//            }
            Keys.selectedBar = "food"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "carrot.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6870872528, green: 0.9167618414, blue: 0.7997073189, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: Float(perc)/100)
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
            
            historyFoodArray = addNewValueInArray(array: historyFoodArray, value: HistoryFoodSlot(image: foodImageView, date: Date(), amount: addAmountVariable))
            
            historyFoodTableView.insertRows(at: [IndexPath(row: historyFoodArray.count - 1 , section: 0)], with: .automatic)
            historyFoodTableView.reloadData()
            
            
            print(Keys.historyFood)
            
            let beforePerc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            amountOfSomething.text = "\((Int(Keys.usedKkal)) + addAmountVariable)/\(Int(Keys.kkal)) ккал"
            Keys.usedKkal = Keys.usedKkal + addAmountVariable
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            percentageLabel.text = "\(Int(perc))%"
            setAlertLabel(on: Keys.selectedBar)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100, from: Float(beforePerc)/100)
        case "water":
            let beforePercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            amountOfSomething.text = "\((Int(Keys.usedWater)) + addAmountVariable)/\(Int(Keys.water)) мл"
            Keys.usedWater = Keys.usedWater + addAmountVariable
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
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
    //TODO: ДОделать
    
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
    
    func addNewValueInArray(array: [HistoryFoodSlot], value: HistorySlot) -> [HistoryFoodSlot] {
        var copyArray = Array(array.reversed())
        copyArray.append(value as! ReversedCollection<[HistoryFoodSlot]>.Element)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
//        case 1 :
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySlot", for: indexPath) as? Cell else { fatalError() }
//            cell.textLabel?.text = "Water"
//            cell.configure(slotHistory: historyWaterArray[indexPath.row])
//            return cell
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

extension Notification.Name{
    static let reload = Notification.Name("reload")
}
