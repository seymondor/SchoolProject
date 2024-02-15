//
//  History.swift
//  MyProjectMaxim
//
//  Created by Максим on 13.02.2024.
//

import Foundation
import UIKit

//TODO: Спросить

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
            var historyFoodDictionary = Keys.historyFood ?? []
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            historyFoodDictionary.append([formattedDate : amount])
            Keys.historyFood = historyFoodDictionary
            super.init(image: image, date: date, amount: amount)
        } else {
            super.init(image: UIImageView(), date: Date(), amount: 0)
        }
    }
}

class HistoryWaterSlot : HistorySlot {
    override init(image: UIImageView, date: Date, amount: Int) {
        if image.image == UIImage(systemName: "drop.fill"){
            var historyWaterDictionary = Keys.historyWater ?? []
            let formattedDate = date.formatted()
            historyWaterDictionary.append([formattedDate:amount])
            Keys.historyWater = historyWaterDictionary
            super.init(image: image, date: date, amount: amount)
        } else {
            super.init(image: UIImageView(), date: Date(), amount: 0)
        }
    }
}
