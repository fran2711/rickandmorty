import SwiftUI

enum CharacterDetailNavigation {
}

protocol CharacterDetailNavigator {
    func navigate(to navigation: CharacterDetailNavigation)
}

@MainActor
class CharacterDetailViewModel: CharacterDetailVM {
    
    var character: Character
    
    
    @Published private (set) var loading: Bool = false
    @Published var alert: AlertUIModel? = nil
    
    
    init(character: Character) {
        self.character = character
    }

    func handle(event: CharacterDetailEvent) {
        switch event {
        case .onAppear: break
        }
    }
}
