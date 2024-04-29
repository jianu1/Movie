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
        if viewModel.favoriteMovies.movies.isEmpty {
            EmptyListView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                    ForEach(viewModel.favoriteMovies.movies) { movie in
                        CardView(movie: movie, image: viewModel.images[movie.id],isFavorite: true, toggleFavorite: {
                            viewModel.removeFavorite(movieID: movie)
                        })
                    }
                }
                .padding()
            }
        }
    }
}

struct EmptyListView: View {
    var body: some View {
        Text("Nu ai adăugat filme la favorite încă.")
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    FavoriteView(viewModel: FavoriteViewModel(favoriteMovies: FavoriteMovies()))
}
