import Foundation
import MyLibraryA
import MyLibraryB

struct Pokemon: Hashable, Decodable, Identifiable, Sendable {
    let id: Int
    let name: String
    let sprites: Sprites

    struct Sprites: Hashable, Decodable, Sendable {
        let front_default: URL
    }

    fileprivate init(id: Int, name: String, sprites: Sprites) {
        actionA()
        actionB()

        self.id = id
        self.name = name
        self.sprites = sprites
    }

    init?(id: Int) async {
        guard
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + id.description + "/"),
            let data = try? await URLSession.shared.data(from: url).0,
            let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
        else {
            return nil
        }

        self.id = pokemon.id
        self.name = pokemon.name
        self.sprites = pokemon.sprites
    }
}

extension Pokemon {
    static let sample: Self = .init(id: 1, name: "bulbasaur", sprites: .init(front_default: .init(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!))
}
