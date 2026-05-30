import SwiftUI

struct PokemonDetailView: View {
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    private let pokemon: Pokemon

    var body: some View {
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
