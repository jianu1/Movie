//
//  HomeView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedCategory: MovieCategory = .popular
    @State private var showingSortSheet: Bool = false
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    var body: some View {
        VStack(spacing: 5.0) {
            ZStack {
                Button(action: { showingSortSheet.toggle() }, label: {
                    Image("ic_sort")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
                .actionSheet(isPresented: $showingSortSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Rating Ascending")) {
                            viewModel.sortMovies(by: .ratingAscending)
                        },
                        .default(Text("Rating Descending")) {
                            viewModel.sortMovies(by: .ratingDescending)
                        },
                        .default(Text("Release Date Ascending")) {
                            viewModel.sortMovies(by: .releaseDateAscending)
                        },
                        .default(Text("Release Date Descending")) {
                            viewModel.sortMovies(by: .releaseDateDescending)
                        },
                        .cancel()
                    ])
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                Text("Home")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity)
            }

            SegmentedView(segments: viewModel.segments, selected: $selectedCategory) { category in
                Task {
                    await viewModel.handleSelection(category: category)
                }
            }
            VStack {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(viewModel.movies) { movie in
                            CardView(movie: movie,image: viewModel.images[movie.id] ,isFavorite: viewModel.isFavorite(movieID: movie), toggleFavorite: {
                                viewModel.toggleFavorite(movie: movie)
                            })
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .background(Color.lightGrayBlue)
            .task {
                await viewModel.loadData(type: .popular)
            }
        }
        .background(.black)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(movieController: MovieController()))
}
