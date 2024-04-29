//
//  ViewModelFactory.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 29.04.2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
    let movieController = MovieController()
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(movieController: movieController)
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel()
    }
    
    func makeFavoriteViewModel() -> FavoriteViewModel {
        return FavoriteViewModel(favoriteMovies: movieController.favoriteMovies)
    }
}
