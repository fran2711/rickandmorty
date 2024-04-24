import SwiftUI

public enum CharacterDetailEvent {
    case onAppear
}

@MainActor
public protocol CharacterDetailVM: ObservableObject {
    var loading: Bool { get }
    var alert: AlertUIModel? { get set }
    
    var character: Character { get }
    
    func handle(event: CharacterDetailEvent)
}

public struct CharacterDetailView<ViewModel: CharacterDetailVM>: View {
    
    @StateObject var viewModel: ViewModel
    
    public init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    public var body: some View {
        
        VStack {
            VStack(spacing: 16) {
                AsyncImage(url: viewModel.character.imageUrl) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .background(Color.gray)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(viewModel.character.name)
                            .font(.title)
                            .fontWeight(.black)
                        
                        Text("(\(viewModel.character.status))")
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Specie:")
                            Text(viewModel.character.species)
                        }
                        .font(.headline)
                        
                        HStack {
                            Text("Type:")
                            Text(viewModel.character.type ?? "")
                        }
                        .font(.headline)
                        
                        HStack {
                            Text("Location:")
                            Text(viewModel.character.location.name)
                        }
                        .font(.headline)
                    }
                }
                .padding(16)
                
            }
            .padding(16)
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .alert(model: $viewModel.alert)
        .loading(loading: viewModel.loading)
        .onAppear {
            viewModel.handle(event: .onAppear)
        }
    }
}

#if DEBUG
class MockCharacterDetailVM: CharacterDetailVM {
    var character: Character =  Character(
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
    
    @Published var alert: AlertUIModel? = nil
    let loading: Bool = false
    
    func handle(event: CharacterDetailEvent) { }
}

@available(iOS 17, *)
#Preview {
    CharacterDetailView.init(viewModel: MockCharacterDetailVM())
}
#endif
