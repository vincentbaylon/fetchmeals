//
//  InstructionsViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/18/21.
//

import UIKit

class InstructionsViewController: UIViewController {
    let instructionsLabel = BodyLabel(textAlignment: .left)
    let scrollView = UIScrollView()
    
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
        configureViewController()
        configureUIElements()
        addSubviews()
        layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureUIElements() {
        instructionsLabel.text = meal.instructions
        instructionsLabel.numberOfLines = 0
    }
    
    func addSubviews() {
        scrollView.addSubview(instructionsLabel)
        self.view.addSubview(scrollView)
    }
    
    func layoutUI() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
            instructionsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -padding),
        ])
    }
}
