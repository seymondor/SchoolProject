//
//  ViewController.swift
//  MyProjectMaxim
//
//  Created by 1 on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    
    func checkButtonManOrWoman(buttonMan:UIButton,buttonWoman:UIButton) -> String {
        if buttonMan.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            return "Man"
        } else if buttonWoman.layer.borderColor == #colorLiteral(red: 0.3026678778, green: 0.6489531224, blue: 0.9067135847, alpha: 1) {
            return "Woman"
        } else {
            return "Error"
        }
    }
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
        if StartEnterHeight.text == "" {
            Keys.height = "Error"
        } else if let height = StartEnterHeight.text {
            Keys.height = height
        }
        if StartEnterWeight.text == "" {
            Keys.weight = "Error"
        } else if let weight = StartEnterWeight.text {
            Keys.weight = weight
        }
        if StartEnterAge.text == "" {
            Keys.age = "Error"
        } else if let age = StartEnterAge.text {
            Keys.age = age
        }
        Keys.gender = checkButtonManOrWoman(buttonMan: OutletManButton, buttonWoman: OutletWomanButton)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StartEnterHeight.textAlignment = .center
        StartEnterWeight.textAlignment = .center
        StartEnterAge.textAlignment = .center
        Label1.text = Keys.height
        Label2.text = Keys.weight
        Label3.text = Keys.age
        Label4.text = Keys.gender
    }
}


