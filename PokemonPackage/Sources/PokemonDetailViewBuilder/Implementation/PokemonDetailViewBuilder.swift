public import SwiftUI
public import Pokemon
public import PokemonDetailViewBuilderInterface

public struct PokemonDetailViewBuilder: PokemonDetailViewBuilderProtocol {
    public init() {}
    
    public func build(_ pokemon: Pokemon) -> some View {
        PokemonDetailView(pokemon)
    }
}

fileprivate struct PokemonDetailView: View {
    public init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    private let pokemon: Pokemon
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("PokemonDetailView")
                .font(.headline)
            Divider()
            Text(pokemon.name)
            Text(pokemon.id.description)
            Text(pokemon.sprites.front_default.absoluteString)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PokemonDetailView(.sample)
}
