//
//  CategoriesViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import UIKit

class CategoriesViewController: UIViewController {
    enum Section {
        case main
    }
    
    var categoriesArray: [Category] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchCategories()
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
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
    }
    
    func fetchCategories() {
        showLoadingView()
        NetworkManager.shared.getCategories { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let categories):
                let categoriesArray: [Category] = categories.categories
                for item in categoriesArray {
                    self.categoriesArray.append(item)
                }
                self.updateData()
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.set(category: category)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoriesArray)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoriesArray[indexPath.item]
        
        let destinationVC = MealsViewController()
        destinationVC.title = category.strCategory
        destinationVC.category = category.strCategory
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
