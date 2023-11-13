//
//  CategoryListModel.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import Foundation


struct CategoryListModel: Codable {
    var categories: [Categories]
}

// MARK: - Category
struct Categories: Codable, Identifiable{
    var id: String
    var strCategory: String?
    var strCategoryThumb: String?
    var strCategoryDescription: String?

    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case strCategory, strCategoryThumb, strCategoryDescription
    }
}
