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
        case timeGetUp
        case timeGoSleep
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
    
    static var timeGetUp: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.timeGetUp.rawValue)
        }
        set {
            if let timeGetUp = newValue {
                UserDefaults.standard.setValue(timeGetUp, forKey: HumanSettings.timeGetUp.rawValue)
            }
        }
    }
    
    static var timeGoSleep : String! {
        set {
            if let timeGoSleep = newValue {
                UserDefaults.standard.setValue(timeGoSleep, forKey: HumanSettings.timeGoSleep.rawValue)
            }
        }
        get {
            UserDefaults.standard.string(forKey: HumanSettings.timeGoSleep.rawValue)
        }
    }
    
    static var minutesToDrink: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.minutesToDrink.rawValue)
        }
        set {
            if let minutesToDrink = newValue {
                UserDefaults.standard.set(minutesToDrink, forKey: HumanSettings.minutesToDrink.rawValue)
            }
        }
    }
    
    static var minutesToEat: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.minutesToEat.rawValue)
        }
        set {
            if let minutesToEat = newValue {
                UserDefaults.standard.set(minutesToEat, forKey: HumanSettings.minutesToEat.rawValue)
            }
        }
    }
    
    static var sport: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.sport.rawValue)
        }
        set {
            if let sport = newValue {
                UserDefaults.standard.set(sport, forKey: HumanSettings.sport.rawValue)
            }
        }
    }

    static var selectedBar: String! {
        get {
            UserDefaults.standard.string(forKey: UsedStandarts.selectedBar.rawValue)
        }
        set {
            if let selectedBar = newValue {
                UserDefaults.standard.set(selectedBar, forKey: UsedStandarts.selectedBar.rawValue)
            }
        }
    }
    
    static var usedKkal: Int! {
        get {
            UserDefaults.standard.integer(forKey: UsedStandarts.usedKkal.rawValue)
        }
        set {
            if let usedKkal = newValue {
                UserDefaults.standard.set(usedKkal, forKey: UsedStandarts.usedKkal.rawValue)
            }
        }
    }
    
    static var usedWater: Int! {
        get {
            UserDefaults.standard.integer(forKey: UsedStandarts.usedWater.rawValue)
        }
        set {
            if let usedWater = newValue {
                UserDefaults.standard.set(usedWater, forKey: UsedStandarts.usedWater.rawValue)
            }
        }
    }
    
    static var kkal: Int! {
        get {
            UserDefaults.standard.integer(forKey: Standarts.kkal.rawValue)
        } set {
            if let kkal = newValue {
                UserDefaults.standard.set(kkal, forKey: Standarts.kkal.rawValue)
            }
        }
    }
    
    static var water: Int! {
        get {
            UserDefaults.standard.integer(forKey: Standarts.water.rawValue)
        } set {
            let defaults = UserDefaults.standard
            if let water = newValue {
                defaults.set(water, forKey: Standarts.water.rawValue)
            }
        }
    }
    
    static var height: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.height.rawValue)
        } set {
            if let height = newValue {
                UserDefaults.standard.set(height, forKey: HumanSettings.height.rawValue)
            }
        }
    }
    
    static var weight: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.weight.rawValue)
        } set {
            if let weight = newValue {
                UserDefaults.standard.set(weight, forKey: HumanSettings.weight.rawValue)
            }
        }
    }
    
    static var age: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.age.rawValue)
        } set {
            if let age = newValue {
                UserDefaults.standard.set(age, forKey: HumanSettings.age.rawValue)
            }
        }
    }
    
    static var gender: String! {
        get {
            UserDefaults.standard.string(forKey: HumanSettings.gender.rawValue)
        } set {
            if let gender = newValue {
                UserDefaults.standard.set(gender, forKey: HumanSettings.gender.rawValue)
            }
        }
    }
    
}
