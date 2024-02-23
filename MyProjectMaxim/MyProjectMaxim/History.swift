//
//  History.swift
//  MyProjectMaxim
//
//  Created by Максим on 13.02.2024.
//

import Foundation
import UIKit

class HistorySlot {
    var image : UIImageView = UIImageView()
    var date : Date = Date()
    var amount : Int = 0
    
    init(image: UIImageView, date: Date, amount: Int) {
        self.image = image
        self.date = date
        self.amount = amount
    }
}

class HistoryFoodSlot : HistorySlot {
    override init(image: UIImageView, date: Date, amount: Int) {
        if image.image == UIImage(named: "carrot") {
            super.init(image: image, date: date, amount: amount)
        } else {
            super.init(image: UIImageView(), date: Date(), amount: 0)
        }
    }
}

class HistoryWaterSlot : HistorySlot {
    override init(image: UIImageView, date: Date, amount: Int) {
        if image.image == UIImage(named: "water"){
            super.init(image: image, date: date, amount: amount)
        } else {
            super.init(image: UIImageView(), date: Date(), amount: 0)
        }
    }
}

func saveSlotInDefaultsFood(array: [HistoryFoodSlot]) {
    for item in array {
        var historyFoodDictionary = Keys.historyFood ?? []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = dateFormatter.string(from: item.date)
        historyFoodDictionary.append([formattedDate : item.amount])
        Keys.historyFood = historyFoodDictionary
    }
}

func saveSlotInDefaultsWater(array: [HistoryWaterSlot]) {
    for item in array {
        var historyWaterDictionary = Keys.historyWater ?? []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = dateFormatter.string(from: item.date)
        historyWaterDictionary.append([formattedDate : item.amount])
        Keys.historyWater = historyWaterDictionary
    }
}
