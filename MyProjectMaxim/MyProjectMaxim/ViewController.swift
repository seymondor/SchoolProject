//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    func createFrameForButton(button: UIButton){
        if button.layer.borderColor == #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1) {
            button.layer.borderColor = #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
        }
    }
    @IBAction func StartManButton(_ sender: UIButton) {
        createFrameForButton(button: sender)
    }
    @IBAction func StartWomanButton(_ sender: UIButton) {
        createFrameForButton(button: sender)
        sender.layer.cornerRadius = 5
        sender.layer.borderWidth = 1
        sender.layer.borderColor = #colorLiteral(red: 0.4778209925, green: 0.7600174546, blue: 0.8799687028, alpha: 1)
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


