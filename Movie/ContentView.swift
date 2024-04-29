//
//  ContentView.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 27.04.2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var currentTab: Int = 1

    var homeViewModel: HomeViewModel
    var searchViewModel: SearchViewModel
    var favoriteViewModel: FavoriteViewModel
    
    init(homeViewModel: HomeViewModel,
         searchViewModel: SearchViewModel,
         favoriteViewModel: FavoriteViewModel
    ){
        self.homeViewModel = homeViewModel
        self.searchViewModel = searchViewModel
        self.favoriteViewModel = favoriteViewModel
        UITabBar.appearance().backgroundColor = UIColor.black
    }
    

    var body: some View {
        TabView(selection: $currentTab) {
            FavoriteView(viewModel: favoriteViewModel)
                .environmentObject(favoriteViewModel)
                .tabItem {
                    Image(currentTab == 0 ? "ic_favorites_press" : "ic_favorites")
                    Text("Favorites")
                }
                .tag(0)
            HomeView(viewModel: homeViewModel)
                .environmentObject(homeViewModel)
                .tabItem {
                    Image(currentTab == 1 ? "ic_home_press" : "ic_home")
                    Text("Home")
                }
                .tag(1)
            SearchView(viewModel: searchViewModel)
                .environmentObject(searchViewModel)
                .tabItem {
                    Image(currentTab == 2 ? "ic_search_press" : "ic_search")
                    Text("Search")
                }
                .tag(2)
        }
        .accentColor(.white)
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor.black
        }
    }
}
