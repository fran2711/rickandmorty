//
//  CharacterResults.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import Foundation

struct CharacterResults: Decodable {
    let info: ResultsInfo
    let results: [Character]
}

struct ResultsInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
