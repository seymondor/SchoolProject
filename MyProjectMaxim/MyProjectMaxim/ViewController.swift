//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Enter2: UITextField!
    @IBOutlet weak var Enter1: UITextField!
    @IBOutlet weak var Enter3: UITextField!
    @IBAction func StartButton(_ sender: UIButton) {
        var Text1 = Enter1.text
        Test.text = Text1
        Test.isHidden = false
    }
    @IBOutlet weak var Test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Test.isHidden = true
        Enter1.textAlignment = .center
        Enter2.textAlignment = .center
        Enter3.textAlignment = .center
    }
}


