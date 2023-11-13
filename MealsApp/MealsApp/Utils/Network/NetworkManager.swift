//
//  NetworkManager.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import UIKit

protocol NetworkManagerProtocol {
    func getCategory(completion: @escaping (Result<[Categories], MAError>) -> Void)
    func getMeal(withID id: String, completion: @escaping (Result<MealModel, MAError>) -> Void)
    func getListOfMeals(withCategory categoryEndPoint: String, completion: @escaping (Result<[MealsModel], MAError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

    static let baseURL = "https://themealdb.com/api/json/v1/1/"
    private let categoryURL = baseURL + "categories.php"
    private let findURL = baseURL + "lookup.php?i="
    private let listMealsbyCategory = baseURL + "filter.php?c="

    private init() {}

    func getCategory(completion: @escaping (Result<[Categories], MAError>) -> Void) {
        guard let url = URL(string: categoryURL) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(CategoryListModel.self, from: data)
                completion(.success(decodedResponse.categories))
            } catch  {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func downloadImage(fromUrlString urlString: String, completion: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }

        task.resume()
    }

    func getListOfMeals(withCategory categoryEndPoint: String, completion: @escaping (Result<[MealsModel], MAError>) -> Void) {
        guard let url = URL(string: "\(listMealsbyCategory)\(categoryEndPoint)") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MealsCategoryModel.self, from: data)
                completion(.success(decodedResponse.meals))
            } catch  {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getMeal(withID mealsId: String, completion: @escaping (Result<MealModel, MAError>) -> Void) {
        guard let url = URL(string: "\(findURL)\(mealsId)") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MealModel.self, from: data)
                completion(.success(decodedResponse))
            } catch  {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

}
