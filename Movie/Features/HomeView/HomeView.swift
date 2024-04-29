//
//  HomeView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(viewModel.movies) { movie in
                    CardView(movie: movie,image: viewModel.images[movie.id] ,isFavorite: viewModel.isFavorite(movieID: movie), toggleFavorite: {
                        viewModel.toggleFavorite(movieID: movie)
                    })
                }
            }
            .padding()
        }
        .background(Color.lightGrayBlue)
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(movieController: MovieController()))
}
