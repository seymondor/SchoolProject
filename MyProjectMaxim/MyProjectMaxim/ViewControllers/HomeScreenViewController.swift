//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit	
import BonsaiController
class HomeScreenViewController: UIViewController {
    @IBOutlet weak var CircularProgress :
        CircularProgressBar!
    @IBOutlet weak var backgroundOfEmojiSelectedBar: UIView!
    @IBOutlet weak var emojiSelectedBar: UIImageView!
    @IBAction func WaterChangeButton(_ sender: UIButton!) {
        if Keys.selectedBar == "water" {
            showAlert(error: "Уже выбран счетчик воды")
        } else {
            changeBar(to: "water")
        }
    }
    @IBAction func foodChangeButton(_ sender: UIButton!) {
        if Keys.selectedBar == "food" {
            showAlert(error: "Уже выбран счетчик еды")
        } else {
            changeBar(to: "food")
        }
    }
//    func changeBarValue(on bar: String){
//        switch bar {
//        case "water":
//            let usedWaterPercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
//            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(usedWaterPercentage)/100,from: 0)
//            percentageLabel.text = "\(Int(usedWaterPercentage))%"
//            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
//        case "food":
//            let usedFoodPercentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
//            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(usedFoodPercentage)/100,from: 0)
//            percentageLabel.text = "\(Int(usedFoodPercentage))%"
//            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
//        default:
//            break
//        }
//    }
    func changeBarValue(withKey keyBar: String, fromValuePercentage: Float, toValuePercentage: Float) {
        switch keyBar {
        case "water":
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(CircularProgress.usedWaterPercentage))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
        case "food":
            CircularProgress.setProgressWithAnimation(duration: 1.0, value: toValuePercentage, from: fromValuePercentage)
            percentageLabel.text = "\(Int(CircularProgress.usedFoodPercentage))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
        default:
            break
        }
    }
    func changeBar(to bar: String) {
        switch bar {
        case "water":
            Keys.selectedBar = "water"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.5811036229, green: 0.7276489139, blue: 0.852099359, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "drop.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: CircularProgress.usedWaterPercentage/100)
        case "food":
            Keys.selectedBar = "food"
            emojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            backgroundOfEmojiSelectedBar.backgroundColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            emojiSelectedBar.image = UIImage(systemName: "carrot.fill")
            CircularProgress.trackColor = #colorLiteral(red: 0.6870872528, green: 0.9167618414, blue: 0.7997073189, alpha: 1)
            CircularProgress.progressColor = #colorLiteral(red: 0.4841163754, green: 0.7172273993, blue: 0.4995424747, alpha: 1)
            changeBarValue(withKey: Keys.selectedBar, fromValuePercentage: 0, toValuePercentage: CircularProgress.usedFoodPercentage/100)
        default:
            break
        }
    }
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var amountOfSomething: UILabel!
    @IBAction func addAmountButton(_ sender: UIButton) {
        if Keys.selectedBar == "water" {
            let waterVC = storyboard!.instantiateViewController(withIdentifier:"WaterAddVC")
            waterVC.transitioningDelegate = self
            waterVC.modalPresentationStyle = .custom
            present(waterVC, animated:true, completion: nil)
//            var usedWaterPercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
//            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(usedWaterPercentage)/100 + 0.1 ,from: Float(usedWaterPercentage)/100)
//            Keys.usedWater = Keys.usedWater + Int((Double(Keys.water) * 0.1))
//            usedWaterPercentage = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
//            percentageLabel.text = "\(Int(usedWaterPercentage))%"
//            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
        } else {
            let foodVC = storyboard!.instantiateViewController(withIdentifier:"FoodAddVC")
            foodVC.transitioningDelegate = self
            foodVC.modalPresentationStyle = .custom
            present(foodVC, animated:true, completion: nil)
//            var usedFoodPercentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
//            CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(usedFoodPercentage)/100 + 0.1 ,from: Float(usedFoodPercentage)/100)
//            Keys.usedKkal = Keys.usedKkal + Int((Double(Keys.kkal) * 0.1))
//            usedFoodPercentage = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
//            percentageLabel.text = "\(Int(usedFoodPercentage))%"
//            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Keys.selectedBar == "water" {
            changeBar(to: "water")
        } else {
            changeBar(to: "food")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if Keys.selectedBar == "water" {
            let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
            CircularProgress.setProgressWithAnimation(duration: 0.0, value: Float(perc)/100 ,from: Float(perc)/100)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
        } else {
            let perc = ceil((Double(Keys.usedKkal)/Double(Keys.kkal))*100)
            CircularProgress.setProgressWithAnimation(duration: 0.0, value: Float(perc)/100 ,from: Float(perc)/100)
            percentageLabel.text = "\(Int(perc))%"
            amountOfSomething.text = "\(Int(Keys.usedKkal))/\(Int(Keys.kkal))kkal"
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

extension HomeScreenViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 1.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (3/4)))
    }
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        /// With Background Color ///
        // Slide animation from .left, .right, .top, .bottom
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.2), presentedViewController: presented, delegate: self)
    }
}
extension Notification.Name{
    static let reload = Notification.Name()
}
