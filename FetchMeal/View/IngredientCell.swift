//
//  IngredientCell.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/17/21.
//

import UIKit

class IngredientCell: UITableViewCell {
    static let reuseID = "IngredientCell"
    let measurementLabel = SecondaryTitleLabel(fontSize: 15)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(measurement: String, ingredient: String) {
        measurementLabel.text = "- " + measurement + " " + ingredient
    }
    
    private func configure() {
        addSubview(measurementLabel)
        
        accessoryType = .none
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            measurementLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            measurementLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            measurementLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            measurementLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
