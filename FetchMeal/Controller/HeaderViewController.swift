//
//  HeaderViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/17/21.
//

import UIKit

class HeaderViewController: UIViewController {
    let mealImageView = ThumbImageView(frame: .zero)
    let mealLabel = DetailsTitleLabel(textAlignment: .left, fontSize: 25)
    let areaLabel = SecondaryTitleLabel(fontSize: 20)
    
    var meal: MealDetails!
    
    init(meal: MealDetails) {
        super.init(nibName: nil, bundle: nil)
        self.meal = meal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        mealLabel.text = meal.name
        mealLabel.numberOfLines = 2
        areaLabel.text = meal.area
        
        NetworkManager.shared.downloadImage(from: meal.image) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.mealImageView.image = image }
        }
    }
    
    func addSubviews() {
        view.addSubview(mealImageView)
        view.addSubview(mealLabel)
        view.addSubview(areaLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            mealImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 150),
            mealImageView.heightAnchor.constraint(equalToConstant: 150),
            
            mealLabel.topAnchor.constraint(equalTo: mealImageView.topAnchor),
            mealLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: textImagePadding),
            mealLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            areaLabel.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: padding),
            areaLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: textImagePadding),
            areaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            areaLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
