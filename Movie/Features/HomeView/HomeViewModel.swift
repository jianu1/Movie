//
//  HomeViewModel.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import SwiftUI
import Combine
import Foundation
import SwiftfulRouting

protocol HomeViewModelProtocol {
    
}

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie]
    var movieController: MovieController
    @ObservedObject var favoriteMovies: FavoriteMovies
    
    private var cancellables = Set<AnyCancellable>()
    
    init(movieController: MovieController) {
        self.movieController = movieController
        self.favoriteMovies = movieController.favoriteMovies
        
        movies = movieController.favoriteMovies.movies
        
        // Observăm modificările în lista favoriteMovies.movies
        favoriteMovies.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func loadData() {
        if let fileURL = Bundle.main.url(forResource: "get_recommendation_response", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decodedResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                self.movies = decodedResponse.results
            } catch {
                print("Eroare la încărcarea datelor: \(error)")
            }
        } else {
            print("Fișierul JSON nu a fost găsit")
        }
    }
    
    // Funcție pentru a verifica dacă un film este favorit
    func isFavorite(movieID: Movie) -> Bool {
        return movieController.isFavorite(movieID: movieID)
    }
    
    // Funcție pentru a face toggle pe un film favorit
    func toggleFavorite(movieID: Movie) {
        movieController.toggleFavorite(movieID: movieID)
    }

}


class MovieController: ObservableObject {
    @Published private(set) var favoriteMovies = FavoriteMovies()
    
    // Funcție pentru a verifica dacă un film este favorit
    func isFavorite(movieID: Movie) -> Bool {
        return favoriteMovies.movies.contains(movieID)
    }
    
    func toggleFavorite(movieID: Movie) {
        if let index = favoriteMovies.movies.firstIndex(of: movieID) {
            favoriteMovies.movies.remove(at: index)
        } else {
            favoriteMovies.movies.append(movieID)
        }
    }
}

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


class FavoriteMovies: ObservableObject {
    @Published var movies: [Movie] = [] {
        didSet {
            objectWillChange.send()
        }
    }
}
