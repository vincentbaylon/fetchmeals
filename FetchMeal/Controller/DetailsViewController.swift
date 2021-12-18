//
//  DetailsViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import UIKit

class DetailsViewController: UIViewController {
    let headerView = UIView()
    let ingredientsView = UIView()
    let instructionsView = UIView()
    var itemViews: [UIView] = []
    var showIngredient = false
    let toggleLabel = SecondaryTitleLabel(fontSize: 18)
    
    var mealID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        fetchMealDetails()
        layoutUI()
        changeOpacity()
    }
    
    func fetchMealDetails() {
        showLoadingView()
        NetworkManager.shared.getMealDetails(for: mealID) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    for item in meal.meals {
                        self.add(childVC: HeaderViewController(meal: item), to: self.headerView)
                        self.add(childVC: IngredientsViewController(meal: item), to: self.ingredientsView)
                        self.add(childVC: InstructionsViewController(meal: item), to: self.instructionsView)
                    }
                }
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        itemViews = [headerView, ingredientsView, instructionsView]
        
        let padding: CGFloat = 20
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        let ingredientSwitch = UISwitch(frame: CGRect(x: 150, y: 150, width: 0, height: 0))
        ingredientSwitch.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        ingredientSwitch.setOn(false, animated: false)
        ingredientSwitch.backgroundColor = UIColor(rgb: 0xff9900, a: 1)
        ingredientSwitch.layer.cornerRadius = 16.0
        ingredientSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ingredientSwitch)
        self.view.addSubview(toggleLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            ingredientsView.topAnchor.constraint(equalTo: ingredientSwitch.bottomAnchor, constant: padding),
            
            instructionsView.topAnchor.constraint(equalTo: ingredientSwitch.bottomAnchor, constant: padding),
            instructionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            ingredientSwitch.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            ingredientSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            toggleLabel.bottomAnchor.constraint(equalTo: ingredientsView.topAnchor, constant: -12),
            toggleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        ])
        
        view.bringSubviewToFront(instructionsView)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func changeOpacity() {
        if (!showIngredient) {
            ingredientsView.isHidden = false
            instructionsView.isHidden = true
            toggleLabel.text = "Ingredients"
        } else {
            ingredientsView.isHidden = true
            instructionsView.isHidden = false
            toggleLabel.text = "Instructions"
        }
    }
    
    @objc func toggleSwitch() {
        showIngredient.toggle()
        changeOpacity()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
