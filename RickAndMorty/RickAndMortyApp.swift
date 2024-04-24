//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            let dataSource = CharactersAPI()
            let charactersListViewModel = CharactersListViewModel(dataSource: dataSource)
            CharactersListView(viewModel: charactersListViewModel)
        }
    }
}
