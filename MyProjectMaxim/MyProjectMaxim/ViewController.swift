//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    func createFrameForButton(button: UIButton, button2: UIButton){
        if button2.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            button2.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
        }
        if button.layer.borderColor == #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1) {
            button.layer.borderColor = #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
        }
    }
    @IBOutlet weak var OutletManButton: UIButton!
    @IBOutlet weak var OutletWomanButton: UIButton!
    @IBAction func StartManButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: OutletWomanButton)
    }
    @IBAction func StartWomanButton(_ sender: UIButton) {
        createFrameForButton(button: sender, button2: OutletManButton)
    }
    @IBOutlet weak var StartEnterWeight: UITextField!
    @IBOutlet weak var StartEnterHeight: UITextField!
    @IBOutlet weak var StartEnterAge: UITextField!
    @IBAction func StartButton(_ sender: UIButton) {
        Keys.height = StartEnterHeight.text
        Keys.weight = StartEnterWeight.text
        Keys.age = StartEnterAge.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StartEnterHeight.textAlignment = .center; StartEnterHeight.layer.cornerRadius = 5;
            StartEnterHeight.layer.borderWidth = 1;
            StartEnterHeight.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
        StartEnterWeight.textAlignment = .center ;
            StartEnterWeight.layer.cornerRadius = 5;
            StartEnterWeight.layer.borderWidth = 1;
            StartEnterWeight.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
        StartEnterAge.textAlignment = .center ;
            StartEnterAge.layer.cornerRadius = 5;
            StartEnterAge.layer.borderWidth = 1;
            StartEnterAge.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
    }
}


