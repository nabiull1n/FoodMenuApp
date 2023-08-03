//
//  MainNetworkRequest.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import Foundation

final class MainNetworkRequest {
    static let shared = MainNetworkRequest()
    
    private init() {}

    func loadMainTableData (completion: @escaping (Result<CategoriesData, Error>) -> Void) {
        guard let url = URL(string: "\(Resources.URL.mainNetworkRequestURL)") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let categoriesData = try? JSONDecoder().decode(CategoriesData.self, from: data) {
                completion(.success(categoriesData))
            }
        }
        task.resume()
    }
}
