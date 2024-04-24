//
//  APICharactersDataSource.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import Foundation

//https://rickandmortyapi.com/api/character/?page=19

protocol APICharactersDataSource {
    func fetchCharacters(page: String) async throws -> CharacterResults?
}

class CharactersAPI: APICharactersDataSource {
    let url = "https://rickandmortyapi.com/api/character/?"
    
    func fetchCharacters(page: String) async throws -> CharacterResults? {
        let response = try await API.data(url: url + page, method: .GET)
        return try response?.decodedResponse(CharacterResults.self)
    }
}

class CharactersMockAPI: APICharactersDataSource {
    func fetchCharacters(page: String) async throws -> CharacterResults? {
        return loadJson(filename: "", with: CharacterResults.self)
    }

}
