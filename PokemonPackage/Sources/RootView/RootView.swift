@_exported import SwiftUI
import PokedexView
import PokemonDetailViewBuilder
import Pokemon

public struct RootView: View {
    @State private var pokemons: [Pokemon] = []
    
    public init() {}
    
    public var body: some View {
        PokedexView(pokemons, pokemonDetailViewBuilder: PokemonDetailViewBuilder())
            .task {
                pokemons = await fetchPokemons()
            }
    }
    
    @concurrent
    nonisolated func fetchPokemons() async -> [Pokemon] {
        await withTaskGroup { group in
            (1...50).forEach { id in
                group.addTask {
                    await Pokemon(id: id)!
                }
            }
            
            return await group.reduce(into: [Pokemon]()) { pokemons, pokemon in
                pokemons.append(pokemon)
            }.sorted { lhs, rhs in
                lhs.id < rhs.id
            }
        }
    }
}

#Preview {
    RootView()
}
