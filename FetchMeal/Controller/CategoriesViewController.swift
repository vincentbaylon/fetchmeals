//
//  CategoriesViewController.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import UIKit

class CategoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
    }

    func fetchCategories() {
        NetworkManager.shared.getCategories { result in
            switch result {
            case .success(let categories):
                print(categories)
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
