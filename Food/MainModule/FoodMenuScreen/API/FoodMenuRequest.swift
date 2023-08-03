//
//  FoodMenuRequest.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import Foundation

final class FoodMenuRequest {
    static let shared = FoodMenuRequest()
    
    private init() {}
    
    func loadFoodCollectionData (completion: @escaping (Result<FoodData, Error>) -> Void) {
        guard let url = URL(string: "\(Resources.URL.foodMenuRequestURL)") else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let foodData = try? JSONDecoder().decode(FoodData.self, from: data) {
                completion(.success(foodData))
            }
        }
        task.resume()
    }
}

