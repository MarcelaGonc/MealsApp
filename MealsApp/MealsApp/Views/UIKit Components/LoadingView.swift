//
//  LoadingView.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ActivityIndicator()
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.primaryColor
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) { }
}
