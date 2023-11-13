//
//  MealsListViewModel.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import Foundation

final class MealsListViewModel: ObservableObject{

    @Published var meals: [MealsModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
    }

    func getMeals(category: String?) {
        isLoading = true
        guard let category else { return }
        networkManager.getListOfMeals(withCategory: category){ result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let meals):
                    self.meals = meals
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
