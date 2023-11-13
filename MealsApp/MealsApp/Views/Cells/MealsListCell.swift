//
//  MealsListCell.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import SwiftUI

struct MealsListCell: View {

    let meals: MealsModel

    var body: some View {
        HStack(spacing: 16) {
            ListRemoteImage(urlString: (meals.strMealThumb ?? ""))
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipped()
                .clipShape(.buttonBorder)
            if let meal = meals.strMeal {
                Text(meal)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.label))
            }
        }
    }
}

#Preview {
    MealsListCell(meals: .init(id: "123",strMeal: "Meals",strMealThumb: "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg"))
}
