//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit
class HomeScreenViewController: UIViewController {
    public static var shared = HomeScreenViewController()
    
    @IBOutlet weak var CircularProgress :
        CircularProgressBar!
    @IBOutlet weak var backgroundOfEmojiSelectedBar: UIView!
    @IBOutlet weak var emojiSelectedBar: UIImageView!
    @IBAction func WaterChangeButton(_ sender: UIButton!) {
        if Keys.selectedBar == "water" {
            showAlertApsent(error: "счетчик воды")
        } else {
            changeBarToWater()
        }
        
    }
    @IBAction func foodChangeButton(_ sender: UIButton!) {
        if Keys.selectedBar == "food" {
            showAlertApsent(error: "счетчик еды")
        } else {
            changeBarToFood()
        }
        
    }
    func changeBarToWater() {
        Keys.selectedBar = "water"
        emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
        backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
        emojiSelectedBar.image = UIImage(systemName: "drop.fill")
        let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
        CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
        CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100,from: 0)
        percentage.text = "\(Int(perc))%"
        amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
    }
    func changeBarToFood() {
        Keys.selectedBar = "food"
        emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
        backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
        emojiSelectedBar.image = UIImage(systemName: "carrot.fill")
        let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
        CircularProgress.trackColor = #colorLiteral(red: 0.6870872528, green: 0.9167618414, blue: 0.7997073189, alpha: 1)
        CircularProgress.progressColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100,from: 0)
        percentage.text = "\(Int(perc))%"
        amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"

    }
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var amountOfSomething: UILabel!
    @IBAction func addAmountButton(_ sender: UIButton) {
        if Keys.selectedBar == "water" {
            var perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100 + 0.1 ,from: Float(perc)/100)
            Keys.usedWater = Keys.usedWater + Int((Double(Keys.water) * 0.1))
            perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            percentage.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"

        } else {
            var perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100 + 0.1 ,from: Float(perc)/100)
            Keys.usedKkal = Keys.usedKkal + Int((Double(Keys.kkal) * 0.1))
            perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            percentage.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"

        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Keys.selectedBar == "water" {
            changeBarToWater()
        } else {
            changeBarToFood()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if Keys.selectedBar == "water" {
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 0.0, value: Float(perc)/100 ,from: Float(perc)/100)
            percentage.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
        } else {
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 0.0, value: Float(perc)/100 ,from: Float(perc)/100)
            percentage.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
        }
    }
    func showAlertApsent(error: String){
        let alert = UIAlertController(title: "Внимание", message: "Уже выбран \(error).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { alert in
            print("Нажал Хорошо")
        }))
        present(alert, animated: true)
    }
}
