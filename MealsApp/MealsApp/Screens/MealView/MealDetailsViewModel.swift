//
//  MealDetailsViewModel.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import Foundation

final class MealDetailsViewModel: ObservableObject {

    @Published var meal: [[String:String?]] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
    }

    func getMeals(mealId: String?) {
        isLoading = true
        guard let mealId else { return }
        networkManager.getMeal(withID: mealId) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let meal):
                    isLoading = false
                    self.meal = meal.meals
                case.failure(let error):
                    switch error {
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData

                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL

                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse

                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }    
}
