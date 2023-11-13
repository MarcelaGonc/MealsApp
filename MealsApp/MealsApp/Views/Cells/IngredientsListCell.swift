//
//  IngredientsListCell.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 12/11/23.
//

import SwiftUI

struct IngredientsListCell: View {

    var ingredient: String
    var measure: String

    var body: some View {
        let urlString = "http://www.themealdb.com/images/ingredients/\(ingredient ?? "").png".replacingOccurrences(of: " ", with: "%20")
        HStack {
            ListRemoteImage(urlString: urlString.lowercased())
                .aspectRatio(contentMode: .fit)
                .background(Color.primaryColor)
                .frame(width: 40)
                .cornerRadius(5)
            Text("\(measure) \(ingredient)")
//            Text(ingredient)
            Spacer()
        }
        .padding(.horizontal, 16)
        .font(.body)
        .fontWeight(.light)
    }
}

#Preview {
    IngredientsListCell(ingredient: "Sugar", measure: "1 cup")
}
