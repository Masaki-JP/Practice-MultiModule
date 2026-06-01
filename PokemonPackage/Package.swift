// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .defaultIsolation(MainActor.self),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
]

let package = Package(
    name: "PokemonPackage",
    platforms: [.iOS(.v26)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PokemonLibrary",
            targets: ["RootView"],
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Pokemon",
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "PokemonDetailViewBuilderInterface",
            dependencies: ["Pokemon"],
            path: "Sources/PokemonDetailViewBuilder/Interface",
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "PokemonDetailViewBuilder",
            dependencies: ["PokemonDetailViewBuilderInterface", "Pokemon"],
            path: "Sources/PokemonDetailViewBuilder/Implementation",
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "PokemonCard",
            dependencies: ["Pokemon"],
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "PokedexView",
            dependencies: ["Pokemon", "PokemonDetailViewBuilderInterface", "PokemonCard"],
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "RootView",
            dependencies: ["PokedexView", "PokemonDetailViewBuilder", "Pokemon"],
            swiftSettings: swiftSettings,
        ),
    ],
    swiftLanguageModes: [.v6]
)
