import SwiftUI

struct PokedexView: View {
    init(_ pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }

    private let pokemons: [Pokemon]

    var body: some View {
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
                PokemonDetailView(pokemon)
                    .navigationTitle(pokemon.name)
            }
        }
    }
}

#Preview {
    PokedexView([.sample])
}
