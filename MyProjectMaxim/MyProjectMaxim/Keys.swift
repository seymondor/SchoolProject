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
        var beforeInitKkal : Int = 10 * Int(Keys.weight)!
        beforeInitKkal = beforeInitKkal + (6 * Int(Keys.height)!)
        beforeInitKkal = beforeInitKkal - (5 * Int(Keys.age)!)
        if Keys.gender == "Woman" {
            Keys.kkal = beforeInitKkal - 161
            var beforeInitWater : Double = Double(Keys.weight)! * 0.03
            beforeInitWater = (beforeInitWater + 30 * 0.6) * 100
            Keys.water = Int(beforeInitWater)
        }
        if Keys.gender == "Man" {
            Keys.kkal = beforeInitKkal + 5
            var beforeInitWater : Double = Double(Keys.weight)! * 0.04
            beforeInitWater = (beforeInitWater + 30 * 0.6) * 100
            Keys.water = Int(beforeInitWater)
        }
        print("KKAL - \(Keys.kkal ?? 0)")
        print("WATER - \(Keys.water ?? 0)")
    }
    static func resetValueUsedKeys() {
        Keys.usedKkal = 0
        Keys.usedWater = 0
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
