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
    static var height: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.height.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.height.rawValue
            if let kladr = newValue {
                defaults.set(kladr, forKey: key)
            }
        }
        
    }
    
    static var weight: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.weight.rawValue)
        } set {
            let defults = UserDefaults.standard
            let key = HumanSettings.weight.rawValue
            if let kladr = newValue {
                defults.set(kladr, forKey: key)
            }
        }
        
    }
    
    static var age: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.age.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.age.rawValue
            if let kladr = newValue {
                defaults.set(kladr, forKey: key)
            }
        }
        
    }
    
    static var gender: String! {
        get {
            return UserDefaults.standard.string(forKey: HumanSettings.gender.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = HumanSettings.gender.rawValue
            if let kladr = newValue {
                defaults.set(kladr, forKey: key)
            }
        }
        
    }
    
    
}
