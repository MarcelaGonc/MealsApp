//
//  MealsCategoryModel.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import Foundation

// MARK: - MealsCategoryModel
struct MealsCategoryModel: Codable {
    var meals: [MealsModel]
}

// MARK: - MealsModel
struct MealsModel: Codable, Identifiable {
    var id: String
    var strMeal: String?
    var strMealThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMealThumb, strMeal
    }
}
