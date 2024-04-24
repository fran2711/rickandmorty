//
//  CharactersListAPITest.swift
//  RickAndMortyTests
//
//  Created by Francisco Lucena on 24/4/24.
//

import XCTest
@testable import RickAndMorty

final class CharactersListAPITest: XCTestCase {

    let mockedCharactersConnection = CharactersMockAPI()
    
    func testCharacterListAPI() async {
        var characterResult: CharacterResults?
        do {
            characterResult = try await mockedCharactersConnection.fetchCharacters(page: "")
        } catch {
            XCTFail()
        }
        
        XCTAssertNotNil(characterResult)
    }

}
