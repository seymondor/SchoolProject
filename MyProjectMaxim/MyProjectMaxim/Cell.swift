//
//  Cell.swift
//  MyProjectMaxim
//
//  Created by Максим on 10.02.2024.
//

import Foundation
import UIKit

class Cell : UITableViewCell {
    
    let image = UIImageView()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let amountLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    	
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [image, timeLabel, amountLabel] .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 40),
            image.heightAnchor.constraint(equalToConstant: 40),
            
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(slotHistory: HistorySlot) {
        image.image = slotHistory.image.image
        timeLabel.text = formatDate(date: slotHistory.date)
        if slotHistory is HistoryFoodSlot {
            amountLabel.text = "\(slotHistory.amount) ккал"
        } else if slotHistory is HistoryWaterSlot {
            amountLabel.text = "\(slotHistory.amount) мл"
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM, HH:mm"
        formatter.timeZone =  .current
        return formatter.string(from: date)
    }
}
