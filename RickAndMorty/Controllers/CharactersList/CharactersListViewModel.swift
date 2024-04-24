//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import Foundation
import SwiftUI

@MainActor
class CharactersListViewModel: CharactersListVM {
    @Published private (set) var loading: Bool = false
    @Published var alert: AlertUIModel? = nil
    
    @Published var charactersList: [Character] = []
    
    var page: String? = "page=1"
    
    let dataSource: APICharactersDataSource
    
    init(dataSource: APICharactersDataSource) {
        self.dataSource = dataSource
    }
    
    func handle(event: CharactersListEvent) {
        switch event {
        case .onAppear:
            getCharactersList()
        case .requestNextPage:
            getCharactersList()
        }
    }
    
    func getCharactersList() {
        loading = true
        Task {
            defer { self.loading = false }
        
            do {
                guard let nextPage = page, let charactersResult = try await dataSource.fetchCharacters(page: nextPage) else {
                    return
                }
                let nextUrl = charactersResult.info.next?.components(separatedBy: "?")
                page = nextUrl?[1]
                charactersList.append(contentsOf: charactersResult.results)
            }
        }
    }
    
    
}
