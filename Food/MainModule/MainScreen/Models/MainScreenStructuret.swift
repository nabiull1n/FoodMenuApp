//
//  MainScreenStructuret.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

struct CategoriesData: Decodable {
    var сategories: [ProductCategory]
}

struct ProductCategory: Decodable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
