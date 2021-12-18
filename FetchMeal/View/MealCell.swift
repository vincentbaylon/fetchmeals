//
//  MealCell.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/17/21.
//

import UIKit

class MealCell: UICollectionViewCell {
    static let reuseID = "MealCell"
    
    let mealImageView = ThumbImageView(frame: .zero)
    let mealLabel = TitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(meal: Meal) {
        mealLabel.text = meal.strMeal
        mealImageView.contentMode = .scaleAspectFill
        
        NetworkManager.shared.downloadImage(from: meal.strMealThumb) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.mealImageView.image = image }
        }
    }
    
    private func configure() {
        addSubview(mealImageView)
        addSubview(mealLabel)
        
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowRadius = 2
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mealImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mealImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mealImageView.heightAnchor.constraint(equalTo: mealImageView.widthAnchor),
            
            mealLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 12),
            mealLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mealLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mealLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
