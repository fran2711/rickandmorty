//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 23/4/24.
//

import SwiftUI

public enum CharactersListEvent {
    case onAppear
    case requestNextPage
}

@MainActor
public protocol CharactersListVM: ObservableObject {
    var loading: Bool { get }
    var alert: AlertUIModel? { get set }
    
    var charactersList: [Character] { get }
    
    func handle(event: CharactersListEvent)
}

struct CharactersListView<ViewModel: CharactersListVM>: View {
    
    @StateObject var viewModel: ViewModel
    
    public init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        NavigationStack {
            
            List(viewModel.charactersList) { character in
                
                NavigationLink {
                   CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
                } label: {
                    CharacterCell(imageUrl: character.imageUrl,
                                  name: character.name)
                    .background(Color.white)
                    .onAppear(perform: {
                        if character == viewModel.charactersList.last {
                            viewModel.handle(event: .requestNextPage)
                        }
                    })
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .loading(loading: viewModel.loading)
        .alert(model: $viewModel.alert)
        .onAppear {
            viewModel.handle(event: .onAppear)
        }
    }
}

#if DEBUG

class MockCharactersListVM: CharactersListVM {
    var loading: Bool = false
    @Published var alert: AlertUIModel? = nil
    
    var charactersList: [Character] = [
        Character(
            id: 0,
            name: "Toxic Rick",
            status: "Dead",
            species: "Humanoid",
            type: "Rick's Toxic Side",
            gender: "Male",
            origin: CharacterOrigin(
                name: "Alien Spa",
                url: "https://rickandmortyapi.com/api/location/64"
            ),
            location: CharacterLocation(
                name: "Earth",
                url: "adsf"
            ),
            image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/27"],
            url: "https://rickandmortyapi.com/api/character/361",
            created: "2018-01-10T18:20:41.703Z"
        ),
        Character(
            id: 0,
            name: "Toxic Rick",
            status: "Dead",
            species: "Humanoid",
            type: "Rick's Toxic Side",
            gender: "Male",
            origin: CharacterOrigin(
                name: "Alien Spa",
                url: "https://rickandmortyapi.com/api/location/64"
            ),
            location: CharacterLocation(
                name: "Earth",
                url: "adsf"
            ),
            image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/27"],
            url: "https://rickandmortyapi.com/api/character/361",
            created: "2018-01-10T18:20:41.703Z"
        )
    ]
    func handle(event: CharactersListEvent) {}
}

#Preview {
    CharactersListView(viewModel: MockCharactersListVM())
}
#endif
