//
//  MAButton.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 12/11/23.
//

import SwiftUI

struct MAButton: View {

    let title: String

    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .background(Color.brandColor)
            .cornerRadius(15)
    }
}


#Preview {
    MAButton(title: "Watch this Recipe!")
}
