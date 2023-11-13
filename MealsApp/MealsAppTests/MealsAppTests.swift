//
//  MealsAppTests.swift
//  MealsAppTests
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import XCTest
import Combine
@testable import MealsApp

class CategoryViewModelTests: XCTestCase {

    func testGetCategories() throws{
        // Arrange
        let viewModel = CategoryViewModel()
        let expectation = XCTestExpectation(description: "Categories loaded successfully")

        // Act
        viewModel.getCategories()

        // Assert
        let cancellable = viewModel.$categories
            .dropFirst()
            .sink { categories in
                XCTAssertFalse(categories.isEmpty, "Categories should not be empty")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5)
        cancellable.cancel()
    }

    func testGetMeals() {
        // Arrange
        let viewModel = MealsListViewModel()
        let expectation = XCTestExpectation(description: "Meals loaded successfully")

        // Act
        viewModel.getMeals(category: "Dessert")

        // Assert
        let cancellable = viewModel.$meals
            .dropFirst()
            .sink { meals in
                XCTAssertFalse(meals.isEmpty, "Meals should not be empty")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5)
        cancellable.cancel()
    }

    func testGetMeal() {
        // Arrange
        let viewModel = MealDetailsViewModel()
        let expectation = XCTestExpectation(description: "Meal loaded successfully")

        // Act
        viewModel.getMeals(mealId: "53053")

        // Assert
        let cancellable = viewModel.$meal
            .dropFirst()
            .sink { meal in
                XCTAssertFalse(meal.isEmpty, "Meal should not be empty")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5)
        cancellable.cancel()
    }

    func testGetMealFailure() {
        // Arrange
        let viewModel = MealDetailsViewModel()
        let networkManagerMock = NetworkManagerMock()
        networkManagerMock.shouldFail = true
        viewModel.networkManager = networkManagerMock
        let expectation = XCTestExpectation(description: "Error loading meal")

        // Act
        viewModel.getMeals(mealId: "TestMealID")

        // Assert
        let cancellable = viewModel.$alertItem
            .dropFirst() // Skip the initial value
            .sink { alertItem in
                XCTAssertNotNil(alertItem, "Alert item should be present")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5)
        cancellable.cancel()
    }

    func testGetCategoriesFailure() throws{
        // Arrange
        let viewModel = CategoryViewModel()
        let networkManagerMock = NetworkManagerMock()
        networkManagerMock.shouldFail = true
        viewModel.networkManager = networkManagerMock
        let expectation = XCTestExpectation(description: "Error loading categories")

        // Act
        viewModel.getCategories()

        // Assert
        let cancellable = viewModel.$alertItem
            .dropFirst() // Skip the initial value
            .sink { alertItem in
                XCTAssertNotNil(alertItem, "Alert item should be present")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5) 
        cancellable.cancel()
    }

    func testGetMealsFailure() throws {
        // Arrange
        let viewModel = MealsListViewModel()
        let networkManagerMock = NetworkManagerMock()
        networkManagerMock.shouldFail = true
        viewModel.networkManager = networkManagerMock
        let expectation = XCTestExpectation(description: "Error loading meals")

        // Act
        viewModel.getMeals(category: "TestCategory")

        // Assert
        let cancellable = viewModel.$alertItem
            .dropFirst()
            .sink { alertItem in
                XCTAssertNotNil(alertItem, "Alert item should be present")
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 5)
        cancellable.cancel()
    }
}

// Mock NetworkManager for testing
class NetworkManagerMock: NetworkManagerProtocol {
    var shoudFail = false

    func getCategory(completion: @escaping (Result<[Categories], MAError>) -> Void) {
        if shouldFail {
            completion(.failure(.invalidURL))
        } else {
            let sampleCategories = [Categories(id: "1", strCategory: "Teste"),
                                    Categories(id: "2", strCategory: "Teste2")]
            completion(.success(sampleCategories))
        }
    }

    func getListOfMeals(withCategory categoryEndPoint: String, completion: @escaping (Result<[MealsModel], MAError>) -> Void) {
        if shouldFail {
            completion(.failure(.unableToComplete))
        } else {
            let mockMeals: [MealsModel] = []
            completion(.success(mockMeals))
        }
    }

    var shouldFail = false

    func getMeal(withID id: String, completion: @escaping (Result<MealModel, MAError>) -> Void) {
        if shouldFail {
            completion(.failure(.unableToComplete))
        } else {
            let dummyMealModel = MealModel(meals: [[:]])
            completion(.success(dummyMealModel))
        }
    }
}

