//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit	
import BonsaiController
var addAmountVariable = " "
class HomeScreenViewController: UIViewController {
    var historyFoodTableView = UITableView()
    var historyWaterTableView = UITableView()
    lazy var historyFoodArray = Keys.historyFood ?? []
    lazy var historyWaterArray = Keys.historyWater ?? []
    @IBOutlet weak var historyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLabel(notification:)), name: Notification.Name("reload"), object: nil)
        switch Keys.selectedBar {
        case "water": 
            changeBar(to: "water")
            setAlertLabel(on: Keys.selectedBar)
            historyView.addSubview(historyWaterTableView)
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            let displayWidth: CGFloat = self.historyView.frame.width
            let displayHeight: CGFloat = self.historyView.frame.height
            historyWaterTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
            historyWaterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            historyWaterTableView.dataSource = self
            historyWaterTableView.delegate = self
//            historyWaterTableView.translatesAutoresizingMaskIntoConstraints = true
//            historyWaterTableView.topAnchor.constraint(equalTo: historyWaterTableView.bottomAnchor, constant: 10).isActive = true
//            historyWaterTableView.leftAnchor.constraint(equalTo: historyWaterTableView.rightAnchor, constant: 10).isActive = true
        default:
            changeBar(to: "food")
            setAlertLabel(on: Keys.selectedBar)
            historyView.addSubview(historyFoodTableView)
            historyFoodTableView.dataSource = self
            historyFoodTableView.delegate = self
//            historyFoodTableView.translatesAutoresizingMaskIntoConstraints = true
//            historyFoodTableView.topAnchor.constraint(equalTo: historyFoodTableView.bottomAnchor, constant: 10).isActive = true
//            historyFoodTableView.leftAnchor.constraint(equalTo: historyFoodTableView.rightAnchor, constant: 10).isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Keys.selectedBar == "water" {
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            setAlertLabel(on: Keys.selectedBar)
            changeBarValue(withKey: "water", fromValuePercentage: Float(percentage)/100, toValuePercentage: Float(percentage)/100)
        } else {
            let percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            setAlertLabel(on: Keys.selectedBar)
            changeBarValue(withKey: "food", fromValuePercentage: Float(percentage)/100, toValuePercentage: Float(percentage)/100)
        }
    }
    
    @IBOutlet weak var CircularProgress :
        CircularProgressBar!
    @IBOutlet weak var backgroundOfEmojiSelectedBar: UIView!
    @IBOutlet weak var emojiSelectedBar: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var amountOfSomething: UILabel!
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
    
    func changeBarValue(withKey keyBar: String, fromValuePercentage: Float, toValuePercentage: Float) {
        switch keyBar {
        case "water":
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
        case "food":
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
        default:
            break
        }
    }
    func changeBar(to bar: String) {
        switch bar {
        case "water":
            // slotHistory1.deleteAllSubviews()
            
            //TODO: Доделать появление слотов

            Keys.selectedBar = "water"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "drop.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: Float(perc)/100)
        case "food":
            // slotHistory1.deleteAllSubviews()
            //TODO: Доделать появление слотов
            let foodImageView = UIImageView()
            let timeLabel = UILabel()
            let addAmountView = UILabel()
            
            foodImageView.translatesAutoresizingMaskIntoConstraints = true
            foodImageView.heightAnchor.constraint(equalTo:foodImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
            foodImageView.backgroundColor = .white
            foodImageView.image = UIImage(named: "carrot")
            
            for items in historyFoodArray {
                let timeMedium = getKeyFromDictionary(fromDictionary: items).suffix(8).prefix(5)
                timeLabel.text = "\(timeMedium)"
                let kkal = getValueFromDictionary(fromDictionary: items)
                addAmountView.text = "\(kkal) kkal"
            }
            
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
            let label = UILabel()
            label.text = "\(getTime(type: "short"))"
            let addAmountView = UILabel()
            addAmountView.text = "\(addAmountVariable) kkal"
            foodImageView.layer.masksToBounds = true
            foodImageView.layer.cornerRadius = 3
            foodImageView.translatesAutoresizingMaskIntoConstraints = true
            foodImageView.heightAnchor.constraint(equalTo:foodImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
            foodImageView.backgroundColor = .white
            foodImageView.image = UIImage(named: "carrot")
            historyFoodArray.append(["\(getDate()) \(getTime(type: "medium"))" : Int(addAmountVariable)!])
            Keys.historyFood = historyFoodArray
            let beforePerc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            amountOfSomething.text = "\((Int(Keys.usedKkal)) + Int(addAmountVariable)!)/\(Int(Keys.kkal))kkal"
            Keys.usedKkal = Keys.usedKkal + Int(addAmountVariable)!
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            percentageLabel.text = "\(Int(perc))%"
            setAlertLabel(on: Keys.selectedBar)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100, from: Float(beforePerc)/100)
        case "water":
            let beforePercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            amountOfSomething.text = "\((Int(Keys.usedWater)) + Int(addAmountVariable)!)/\(Int(Keys.water))ml"
            Keys.usedWater = Keys.usedWater + Int(addAmountVariable)!
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            percentageLabel.text = "\(Int(percentage))%"
            setAlertLabel(on: Keys.selectedBar)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(percentage)/100, from: Float(beforePercentage)/100)
        default:
            break
        }
    }
    func addNewValueInStackViewHistory(stackView: UIStackView,image: UIImageView, label: UILabel, amountLabel: UILabel) {
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(amountLabel)
    }
    func getTime(type: String) -> String {
        let formatter = DateFormatter()
        switch type {
        case "short":
            formatter.timeStyle = .short
        case "medium":
            formatter.timeStyle = .medium
        default:
            return ""
        }
        return formatter.string(from: Date())
    }
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: Date())
    }
    func setAlertLabel(on bar: String){
        switch bar {
        case "water":
            let percentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            if percentage > 100 { alertLabel.text = "❗️Вы перепиваете"; alertLabel.isHidden = false; } else { alertLabel.isHidden = true }
        default:
            let percentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            if percentage > 100 { alertLabel.text = "❗️Вы переедаете"; alertLabel.isHidden = false; } else { alertLabel.isHidden = true }
        }
    }
    func showAlert(error: String){
        let alert = UIAlertController(title: "Внимание", message: "\(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
}
extension UIStackView {
    func deleteAllSubviews() {
        for item in arrangedSubviews {
            removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
}
extension HomeScreenViewController: BonsaiControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1 :
            return historyWaterArray.count
        case 2 :
            return historyFoodArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 1.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (3/4)))
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.2), presentedViewController: presented, delegate: self)
    }
}
extension Notification.Name{
    static let reload = Notification.Name("reload")
}
