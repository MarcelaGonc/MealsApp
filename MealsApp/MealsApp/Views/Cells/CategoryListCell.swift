//
//  CategoryListCell.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import SwiftUI

struct CategoryListCell: View {

    let category: Categories

    var body: some View {
        HStack(spacing: 16) {
            ListRemoteImage(urlString: category.strCategoryThumb ?? "")
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .clipShape(.buttonBorder)
            if let category = category.strCategory {
                Text(category)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.label))
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    CategoryListCell(category: .init(id: "123", strCategory: "Dessert", strCategoryThumb: "https://www.themealdb.com/images/category/beef.png"))
}

