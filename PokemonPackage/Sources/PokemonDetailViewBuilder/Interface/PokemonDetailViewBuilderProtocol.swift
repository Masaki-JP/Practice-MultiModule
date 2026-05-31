public import SwiftUI
public import Pokemon

public protocol PokemonDetailViewBuilderProtocol {
    associatedtype V: View
    
    func build(_ pokemon: Pokemon) -> V
}
