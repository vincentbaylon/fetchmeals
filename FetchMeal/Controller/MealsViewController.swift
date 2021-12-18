//
//  MealsViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import UIKit

class MealsViewController: UIViewController {
    enum Section {
        case main
    }
    
    var category: String!
    var mealsArray: [Meal] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Meal>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchMeals()
        configureDataSource()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Helper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MealCell.self, forCellWithReuseIdentifier: MealCell.reuseID)
    }
    
    func fetchMeals() {
        showLoadingView()
        NetworkManager.shared.getMeals(for: category) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let meals):
                let mealsArray: [Meal] = meals.meals
                for item in mealsArray {
                    self.mealsArray.append(item)
                }
                self.updateData()
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Meal>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, meal) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.reuseID, for: indexPath) as! MealCell
            cell.set(meal: meal)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Meal>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mealsArray)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension MealsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = mealsArray[indexPath.item]
        
        let destinationVC = DetailsViewController()
        destinationVC.mealID = meal.idMeal
        
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
    }
}
