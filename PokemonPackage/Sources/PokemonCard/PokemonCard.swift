public import SwiftUI
public import Pokemon

public struct PokemonCard: View {
    private let pokemon: Pokemon

    public init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    public var body: some View {
        AsyncImage(url: pokemon.sprites.front_default) { imagePhase in
            switch imagePhase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottom) {
                        Text(pokemon.name)
                            .lineLimit(1)
                    }
            case .failure:
                Text("Error")
            @unknown default:
                fatalError()
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    PokemonCard(.sample)
}
