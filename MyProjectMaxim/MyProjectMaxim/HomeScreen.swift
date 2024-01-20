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
    @IBAction func AddWater(_ sender: UIButton) {
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0.7,from: 0.6)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CircularProgress.trackColor = #colorLiteral(red: 0.6807348041, green: 0.8550895293, blue: 1, alpha: 1)
        CircularProgress.progressColor = #colorLiteral(red: 0.4277995191, green: 0.7138730807, blue: 1, alpha: 1)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0.6,from: 0)
        
    }
}
