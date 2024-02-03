//
//  Keys.swift
//  MyProjectMaxim
//
//  Created by 1 on 04.11.2023.
//
import Foundation
import UIKit
final class Keys {
    private enum HumanSettings: String{
        case height
        case weight
        case age
        case gender
        case sport
        case minutesToEat
        case minutesToDrink
    }
    private enum Standarts: String{
        case kkal
        case water
    }
    private enum UsedStandarts : String{
        case usedKkal
        case usedWater
        case selectedBar
    }
    static func checkTextField(textField : UITextField, fromNumber : Int, upToNumber : Int) -> (isEmpty: Bool, isInRange: Bool) {
        var isInRange = false
        var isEmpty = true
        let number = Int(textField.text!) ?? 0
        if number != 0 { isEmpty = false }
        if number < upToNumber && number > fromNumber {
            isInRange = true
        }
        return (isEmpty, isInRange)
    }
    static func calculateStandarts(){
        if Keys.gender == "Woman" {
            var beforeInitKkal = 9.6 * Double(Keys.weight!)!
            beforeInitKkal = beforeInitKkal + 655 + (1.8 * Double(Keys.height!)!)
            beforeInitKkal = beforeInitKkal - (4.7 * Double(Keys.age!)!)
            Keys.kkal = Int(beforeInitKkal)
            var beforeInitWater = Double(Keys.weight)! * 0.03
            beforeInitWater = (beforeInitWater + (Double(Keys.sport!)! * 0.6)) * 100
            Keys.water = Int(beforeInitWater)
        }
        if Keys.gender == "Man" {
            var beforeInitKkal = 15 * Double(Keys.weight!)!
            beforeInitKkal = beforeInitKkal + 66 + (5 * Double(Keys.height!)!)
            beforeInitKkal = beforeInitKkal - (6.8 * Double(Keys.age!)!)
            Keys.kkal = Int(beforeInitKkal)
            var beforeInitWater = Double(Keys.weight)! * 0.04
            beforeInitWater = (beforeInitWater + (Double(Keys.sport!)! * 0.7)) * 100
            Keys.water = Int(beforeInitWater)
        }
        print("KKAL - \(Keys.kkal ?? 0)")
        print("WATER - \(Keys.water ?? 0)")
    }
    static func resetValueUsedKeys() {
        Keys.usedKkal = 0
        Keys.usedWater = 0
    }
    static var minutesToDrink: String! {
        get{
            return UserDefaults.standard.string(forKey: "drink")
        }
        set{
            if let minutesToDrink = newValue {
                UserDefaults.standard.set(minutesToDrink, forKey: "drink")
            }
        }
    }
    static var minutesToEat: String! {
        get{
            return UserDefaults.standard.string(forKey: "eat")
        }
        set{
            if let minutesToEat = newValue {
                UserDefaults.standard.set(minutesToEat, forKey: "eat")
            }
        }
    }
    static var sport: String! {
        get{
            return UserDefaults.standard.string(forKey: "sport")
        }
        set{
            if let sport = newValue {
                UserDefaults.standard.set(sport, forKey: "sport")
            }
        }
    }

    static var selectedBar: String! {
        get{
            return UserDefaults.standard.string(forKey: "bar")
        }
        set{
            if let selectedBar = newValue {
                UserDefaults.standard.set(selectedBar, forKey: "bar")
            }
        }
    }
    static var usedKkal: Int! {
        get{
            return UserDefaults.standard.integer(forKey: "usedKkal")
        }
        set{
            if let usedKkal = newValue {
                UserDefaults.standard.set(usedKkal, forKey: "usedKkal")
            }
        }
    }
    static var usedWater: Int! {
        get{
            return UserDefaults.standard.integer(forKey: "usedWater")
        }
        set{
            if let usedWater = newValue {
                UserDefaults.standard.set(usedWater, forKey: "usedWater")
            }
        }
    }
    static var kkal: Int! {
        get {
            return UserDefaults.standard.integer(forKey: "kkal")
        } set {
            if let kkal = newValue {
                UserDefaults.standard.set(kkal, forKey: "kkal")
            }
        }
        
    }
    static var water: Int! {
        get {
            return UserDefaults.standard.integer(forKey: "water")
        } set {
            let defaults = UserDefaults.standard
            if let water = newValue {
                defaults.set(water, forKey: "water")
            }
        }
        
    }
    static var height: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.height.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.height.rawValue
            if let height = newValue {
                defaults.set(height, forKey: key)
            }
        }
        
    }
    
    static var weight: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.weight.rawValue)
        } set {
            let defults = UserDefaults.standard
            let key = HumanSettings.weight.rawValue
            if let weight = newValue {
                defults.set(weight, forKey: key)
            }
        }
        
    }
    
    static var age: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.age.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.age.rawValue
            if let age = newValue {
                defaults.set(age, forKey: key)
            }
        }
        
    }
    
    static var gender: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.gender.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.gender.rawValue
            if let gender = newValue {
                defaults.set(gender, forKey: key)
            }
        }
        
    }
    
    
}
