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
        
        NetworkManager.shared.getCategories()
    }

}
