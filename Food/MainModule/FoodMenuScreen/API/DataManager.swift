//
//  DataManager.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import Foundation

protocol FoodMenuDataManagerDelegate: AnyObject {
    func loadData(completion: @escaping ([Dish]) -> Void)
}

final class FoodMenuDataManager: FoodMenuDataManagerDelegate {
    func loadData(completion: @escaping ([Dish]) -> Void) {
        
        FoodMenuRequest.shared.loadFoodCollectionData { result in
            
            switch result {
                case .success(let data):
                    completion (data.dishes ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
