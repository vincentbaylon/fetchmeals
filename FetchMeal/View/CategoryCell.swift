//
//  CategoryCell.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseID = "CategoryCell"
    
    let categoryImageView = ThumbImageView(frame: .zero)
    let categoryLabel = TitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: Category) {
        categoryLabel.text = category.strCategory
        categoryImageView.contentMode = .scaleAspectFill
        
        NetworkManager.shared.downloadImage(from: category.strCategoryThumb) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.categoryImageView.image = image }
        }
    }
    
    private func configure() {
        addSubview(categoryImageView)
        addSubview(categoryLabel)
        
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowRadius = 2
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
