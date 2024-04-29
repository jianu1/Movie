//
//  ContentView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 27.04.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var homeViewModel: HomeViewModel
    var searchViewModel: SearchViewModel
    var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        TabView {
            HomeView(viewModel: homeViewModel)
                .environmentObject(homeViewModel)
                .tabItem { Text("Home") }
            SearchView(viewModel: searchViewModel)
                .environmentObject(searchViewModel)
                .tabItem { Text("Search") }
            FavoriteView(viewModel: favoriteViewModel)
                .environmentObject(favoriteViewModel)
                .tabItem { Text("Favorites") }
        }
        .background(Color.black)
    }
}
