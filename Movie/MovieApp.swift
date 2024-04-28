//
//  MovieApp.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 27.04.2024.
//

import SwiftUI
import SwiftData

@main
struct MovieApp: App {

    var body: some Scene {
        let viewModelFactory = ViewModelFactory()

        WindowGroup {
            ContentView(homeViewModel: viewModelFactory.makeHomeViewModel(),
                        searchViewModel: viewModelFactory.makeSearchViewModel(),
                        favoriteViewModel: viewModelFactory.makeFavoriteViewModel())
            .environmentObject(viewModelFactory)
        }
    }
}
