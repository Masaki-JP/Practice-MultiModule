public import SwiftUI
public import PokemonDetailViewBuilderInterface
import PokemonCard
public import Pokemon

public struct PokedexView<PokemonDetailViewBuilderType: PokemonDetailViewBuilderProtocol>: View {
    public init(_ pokemons: [Pokemon], pokemonDetailViewBuilder: PokemonDetailViewBuilderType) {
        self.pokemons = pokemons
        self.pokemonDetailViewBuilder = pokemonDetailViewBuilder
    }

    private let pokemons: [Pokemon]
    private let pokemonDetailViewBuilder: PokemonDetailViewBuilderType

    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 150))]) {
                    ForEach(pokemons) { pokemon in
                        NavigationLink(value: pokemon) {
                            PokemonCard(pokemon)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .contentMargins(.horizontal, 8, for: .scrollContent)
            .navigationTitle("Pokedex")
            .navigationDestination(for: Pokemon.self) { pokemon in
                pokemonDetailViewBuilder.build(pokemon)
                    .navigationTitle(pokemon.name)
            }
        }
    }
}

#Preview {
    struct Builder: PokemonDetailViewBuilderProtocol {
        func build(_ pokemon: Pokemon) -> some View {
            Text("PokemonDetailView demo")
        }
    }
    
    return PokedexView([.sample], pokemonDetailViewBuilder: Builder())
}
