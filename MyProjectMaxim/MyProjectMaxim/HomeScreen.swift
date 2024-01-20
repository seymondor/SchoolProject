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
    @IBAction func AddWater(_ sender: UIButton) {
        var perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100 + 0.1 ,from: Float(perc)/100)
        Keys.usedWater = Keys.usedWater + Int((Double(Keys.water) * 0.1))
        perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
        percentage.text = "\(Int(perc))%"
        amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let perc = ceil((Double(Keys.usedWater)/Double(Keys.water))*100)
        CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
        CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(perc)/100,from: 0)
        percentage.text = "\(Int(perc))%"
        amountOfSomething.text = "\(Int(Keys.usedWater))/\(Int(Keys.water))ml"
    }
}
