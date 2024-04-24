//
//  CharacterListViewModelTest.swift
//  RickAndMortyTests
//
//  Created by Francisco Lucena on 24/4/24.
//

import XCTest
@testable import RickAndMorty

final class CharacterListViewModelTest: XCTestCase {
    
    let mockedCharactersConnection = CharactersMockAPI()
    
    @MainActor func testViewModelFetchData() async {
        let viewModel = CharactersListViewModel(dataSource: mockedCharactersConnection)
        viewModel.handle(event: .onAppear)
        XCTAssertNotNil(viewModel.charactersList)
    }
    
}
