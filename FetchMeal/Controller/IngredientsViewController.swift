//
//  IngredientsViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/17/21.
//

import UIKit

class IngredientsViewController: UIViewController {
    let tableView = UITableView()
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
        configureTableView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 25
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseID)
    }
}

extension IngredientsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.ingredients.count > meal.measurements.count ? meal.ingredients.count : meal.measurements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseID) as! IngredientCell
        cell.set(measurement: meal.measurements[indexPath.row], ingredient: meal.ingredients[indexPath.row])
        return cell
    }
}
