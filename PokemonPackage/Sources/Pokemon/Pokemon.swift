public import Foundation

nonisolated
public struct Pokemon: Hashable, Decodable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let sprites: Sprites

    public  struct Sprites: Hashable, Decodable, Sendable {
        public let front_default: URL
    }

    fileprivate init(id: Int, name: String, sprites: Sprites) {
        self.id = id
        self.name = name
        self.sprites = sprites
    }

    public init?(id: Int) async {
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
    public  static let sample: Self = .init(id: 1, name: "bulbasaur", sprites: .init(front_default: .init(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!))
}
