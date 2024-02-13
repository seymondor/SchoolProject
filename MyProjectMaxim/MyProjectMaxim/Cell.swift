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
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let amountLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 32),
            image.heightAnchor.constraint(equalToConstant: 32),
            
            timeLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            
            amountLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            amountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    // TODO: ДОделать
    func configure(slotHistory: HistoryFoodSlot) {
        
    }
    
}
