//
//  MealsListView.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import SwiftUI

struct MealsListView: View {

    @StateObject var viewModel = MealsListViewModel()
    var category: String?

    var body: some View {
        ZStack {
            NavigationStack{
                List(viewModel.meals) { meal in
                    NavigationLink{
                        MealDetailsView(idMeal: meal.id)
                    } label: {
                        MealsListCell(meals: meal)
                    }
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { d in
                        d[.leading]
                    })
                    .alignmentGuide(.listRowSeparatorTrailing, computeValue: { d in
                        d[.trailing]
                    })
                }
                .overlay(LoadingView().opacity(viewModel.isLoading ? 1 : 0))
                .navigationTitle(category ?? "Default")
            }
        }
        .onAppear {
            viewModel.getMeals(category: category)
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    MealsListView(category: "Dessert")
}
