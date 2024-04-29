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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(viewModel.favoriteMovies.movies) { movie in
                    CardView(movie: movie, isFavorite: true, toggleFavorite: {
                        viewModel.removeFavorite(movieID: movie)
                    })
                }
            }
            .padding()
        }
    }
}

#Preview {
    FavoriteView(viewModel: FavoriteViewModel(favoriteMovies: FavoriteMovies()))
}
