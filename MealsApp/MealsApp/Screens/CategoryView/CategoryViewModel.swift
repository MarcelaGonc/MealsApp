//
//  CategoryViewModel.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 09/11/23.
//

import Foundation

final class CategoryViewModel: ObservableObject {

    @Published var categories: [Categories] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
    }

    func getCategories() {
        isLoading = true
        networkManager.getCategory { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let categories):
                    self.categories = categories
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
