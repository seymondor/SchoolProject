//
//  History.swift
//  MyProjectMaxim
//
//  Created by Максим on 13.02.2024.
//

import Foundation
import UIKit



class HistoryFoodSlot {
    var image : UIImageView = UIImageView()
    var date : Date = Date()
    var amount : Int = 0
    
    init(image: UIImageView, date: Date, amount: Int) {
        guard image.image == UIImage(named: "carrot") else { return }
        var historyFoodDictionary = Keys.historyFood ?? []
        let formattedDate = date.formatted()
        print(formattedDate)
        historyFoodDictionary.append([formattedDate : amount])
        Keys.historyFood = historyFoodDictionary
        
        self.image = image
        self.date = date
        self.amount = amount
        
        print("successful")
    }
    
}

class HistoryWaterSlot {
    var image : UIImageView = UIImageView()
    var date : Date = Date()
    var amount : Int = 0
    
    init(image: UIImageView, date: Date, amount: Int) {
        guard image.image == UIImage(systemName: "drop.fill") else { return }
        var historyWaterDictionary = Keys.historyWater ?? []
        let formattedDate = date.formatted()
        print(formattedDate)
        historyWaterDictionary.append([formattedDate:amount])
        Keys.historyWater = historyWaterDictionary
        
        self.image = image
        self.date = date
        self.amount = amount
        
        print("successful")
    }
    
}
