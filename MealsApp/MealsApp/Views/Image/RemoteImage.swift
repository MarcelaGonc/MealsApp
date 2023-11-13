//
//  RemoteImage.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 10/11/23.
//

import SwiftUI

final class ImageLoader: ObservableObject {

    @Published var image: Image? = nil

    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromUrlString: urlString) { uiImage in
            guard let uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?

    var body: some View {
        image?.resizable() ?? Image("mealplaceholder").resizable()
    }
}

struct ListRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let urlString: String

    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}
