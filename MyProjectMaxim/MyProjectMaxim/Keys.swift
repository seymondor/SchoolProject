//
//  Keys.swift
//  MyProjectMaxim
//
//  Created by 1 on 04.11.2023.
//
import Foundation
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
//        get {
//            return UserDefaults.standard.string(forKey: HumanSettings.height.rawValue)
//        } 
//        set {
//            let defaults = UserDefaults.standard
//            let key = HumanSettings.height.rawValue
//            if let height = newValue {
//                defaults.set(height, forKey: key)
//            }
//        }
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
