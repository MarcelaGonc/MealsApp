//
//  MealDetailsView.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import SwiftUI
import Foundation

struct MealDetailsView: View {

    var idMeal: String?
    @StateObject var viewModel = MealDetailsViewModel()
    @Environment(\.openURL) var openURL


    var body: some View {
        ZStack {
            NavigationStack {
                ForEach(viewModel.meal, id: \.self) { meal in
                    ScrollView {
                        VStack {
                            if let imageString = meal["strMealThumb"]{
                                ListRemoteImage(urlString: imageString!)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 250)
                                    .cornerRadius(30)
                                    .clipped()
                                    .padding(16)
                            }

                            if let titleRecipe = meal["strMeal"] {
                                Text(titleRecipe!)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 8)
                            }
                            VStack {
                                Text("Ingredients")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                ForEach((1...20), id: \.self) { index in
                                    if let ingredient = meal["strIngredient\(index)"], ingredient != "", ingredient != nil,
                                       let measure = meal["strMeasure\(index)"], measure != "", measure != nil{
                                        IngredientsListCell(ingredient: ingredient!, measure: measure!)
                                    }
                                }
                            }
                            .padding(.bottom, 16)
                            Text("Preparation")
                                .font(.title2)
                                .fontWeight(.medium)
                            if let instructions = meal["strInstructions"] {
                                Text(instructions!.replacingOccurrences(of: "\n", with: "\n\n"))
                                    .multilineTextAlignment(.leading)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .padding(16)
                            }
                            if let youtubeURLString = meal["strYoutube"], let youtubeURL = URL(string: youtubeURLString!) {
                                Button {
                                    openURL(youtubeURL)
                                }  label: {
                                    MAButton(title: "Watch this Recipe")
                                }
                                .padding(.bottom, 16)
                            }
                        }
                    }
                    .navigationTitle("Recipe")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .overlay(LoadingView().opacity(viewModel.isLoading ? 1 : 0))
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
            .onAppear {
                viewModel.getMeals(mealId: idMeal)
            }
        }
    }
}

#Preview {
    MealDetailsView(idMeal: "52874")
}
