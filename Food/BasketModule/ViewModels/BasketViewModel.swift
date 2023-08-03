//
//  BasketViewModel.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import Foundation
import RealmSwift

protocol BasketViewModelDelegate {
    var dishesArray: [DishRealm] { get }
    var totalPrice: Int { get }
    
    var dishesArrayDidChange: (([DishRealm]) -> Void)? { get set }
    var newPrice: ((Int) -> Void)? { get set }
    
    func loadDishesFromRealm()
    func decrementItemCount(_ dishId: Int)
    func incrementItemCount(_ dishId: Int)
    func updateTotalPrice()
}

final class BasketViewModel: BasketViewModelDelegate {
    
    private let realmDataManager: RealmDataManagerDelegate
    private let basketCalculator: BasketCalculator
    
    init(realmDataManager: RealmDataManagerDelegate, basketCalculator: BasketCalculator) {
        self.realmDataManager = realmDataManager
        self.basketCalculator = basketCalculator
    }
    
    var dishesArray: [DishRealm] = [] {
        didSet {
            dishesArrayDidChange?(dishesArray)
            
        }
    }
    
    var totalPrice: Int = 0 {
        didSet {
            newPrice?(totalPrice)
        }
    }
    
    var dishesArrayDidChange: (([DishRealm]) -> Void)?
    var newPrice: ((Int) -> Void)?
    
    func loadDishesFromRealm() {
        dishesArray = realmDataManager.loadDishes()
    }
    
    func decrementItemCount(_ dishId: Int) {
        var count = UserDefaults.standard.integer(forKey: "\(dishId)")
        
        count -= 1
        
        if count <= 0 {
            totalPrice = basketCalculator.updateTotalPriceByRemovingItem(at: dishId)
            
            if let index = dishesArray.firstIndex(where: { $0.id == dishId }) {
                realmDataManager.removeDish(at: dishId)
                dishesArray.remove(at: index)
            }
            UserDefaults.standard.removeObject(forKey: "\(dishId)")
            
            if dishesArray.isEmpty, let bundleIdentifier = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
            }
        } else {
            UserDefaults.standard.set(count, forKey: "\(dishId)")
            totalPrice = basketCalculator.updateTotalPriceByRemovingItem(at: dishId)
        }
    }
    
    func incrementItemCount(_ dishId: Int) {
        var count = UserDefaults.standard.integer(forKey: "\(dishId)")
        
        if count >= 1 {
            count += 1
        } else {
            count = 2
        }
        totalPrice = basketCalculator.updateTotalPriceByAddingItem(at: dishId)
        UserDefaults.standard.set(count, forKey: "\(dishId)")
    }
    
    func updateTotalPrice() {
        totalPrice = basketCalculator.calculateTotalPrice(dishesArray)
    }
}

