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
    override func viewDidLoad() {
        super.viewDidLoad()
//        let cp = CircularProgressBar(frame: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
//        cp.trackColor = UIColor.red
//        cp.progressColor = UIColor.yellow
//        cp.tag = 101
//        self.view.addSubview(cp)
//        cp.center = self.view.center
//        self.perform(#selector(animateProgress), with: nil, afterDelay: 2.0)
        CircularProgress.trackColor = UIColor.white
        CircularProgress.trackColor = UIColor.purple
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0.6)
        
    }
//    @objc func animateProgress() {
//        let cP = self.view.viewWithTag(101) as! CircularProgressBar
//        cP.setProgressWithAnimation(duration: 1.0, value: 0.7)
//    }
}
