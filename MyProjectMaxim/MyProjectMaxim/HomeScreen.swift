//
//  HomeScreen.swift
//  MyProjectMaxim
//
//  Created by 1 on 13.01.2024.
//

import Foundation
import UIKit
class HomeScreenViewController: UIViewController {
    @IBOutlet weak var CircularProgress :
        CircularProgressBar!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var amountOfSomething: UILabel!
    var fromNumber : Float = 0.0
    var usedWater = 0
    @IBAction func AddWater(_ sender: UIButton) {
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: fromNumber + 0.1 ,from: fromNumber)
        fromNumber = fromNumber + 0.1
        percentage.text = "\(Int(fromNumber * 100))%"
        usedWater = usedWater + Int((Double(Keys.water) * 0.1))
        Keys.usedWater = Int(usedWater)
        amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
        CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0,from: 0)
        percentage.text = ""
        amountOfSomething.text = "0/\(Int(Keys.water))ml"
    }
}
