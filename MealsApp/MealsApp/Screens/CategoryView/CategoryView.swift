//
//  CategoryView.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 08/11/23.
//

import SwiftUI

struct CategoryView: View {

    @StateObject var viewModel = CategoryViewModel()

    var body: some View {
        ZStack {
            NavigationStack{
                List(viewModel.categories) { category in
                    NavigationLink {
                        MealsListView(category: category.strCategory)
                    } label: {
                        CategoryListCell(category: category)
                    }
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { d in
                        d[.leading]
                    })
                    .alignmentGuide(.listRowSeparatorTrailing, computeValue: { d in
                        d[.trailing]
                    })
                }
                .padding(.horizontal, 0)
                .navigationTitle("Categories")
                .navigationBarBackButtonHidden()
            }
            .onAppear {
                viewModel.getCategories()
            }

            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    CategoryView()
}
