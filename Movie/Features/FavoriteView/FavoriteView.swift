//
//  FavoriteView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var viewModel: FavoriteViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.favoriteMovies.movies) { movie in
                    // Afiseaza fiecare film favorit intr-o celula sau un alt tip de vizualizare
                    Text(movie.title)
                }
            }
            .padding()
        }
    }
}

#Preview {
    FavoriteView(viewModel: FavoriteViewModel(favoriteMovies: FavoriteMovies()))
}
