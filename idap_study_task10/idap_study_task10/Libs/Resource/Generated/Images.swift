// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Images {
  public static let allPokemons = ImageAsset(name: "all_pokemons")
  public static let backArrow = ImageAsset(name: "back_arrow")
  public static let bg = ImageAsset(name: "bg")
  public static let icon24 = ImageAsset(name: "icon24")
  public static let pokemon = ImageAsset(name: "pokemon")
  public enum PokemonTypeIcons {
    public static let bug = ImageAsset(name: "pokemonTypeIcons/bug")
    public static let dark = ImageAsset(name: "pokemonTypeIcons/dark")
    public static let dragon = ImageAsset(name: "pokemonTypeIcons/dragon")
    public static let electric = ImageAsset(name: "pokemonTypeIcons/electric")
    public static let fairy = ImageAsset(name: "pokemonTypeIcons/fairy")
    public static let fighting = ImageAsset(name: "pokemonTypeIcons/fighting")
    public static let fire = ImageAsset(name: "pokemonTypeIcons/fire")
    public static let flying = ImageAsset(name: "pokemonTypeIcons/flying")
    public static let ghost = ImageAsset(name: "pokemonTypeIcons/ghost")
    public static let grass = ImageAsset(name: "pokemonTypeIcons/grass")
    public static let ground = ImageAsset(name: "pokemonTypeIcons/ground")
    public static let icy = ImageAsset(name: "pokemonTypeIcons/icy")
    public static let normal = ImageAsset(name: "pokemonTypeIcons/normal")
    public static let poison = ImageAsset(name: "pokemonTypeIcons/poison")
    public static let psychic = ImageAsset(name: "pokemonTypeIcons/psychic")
    public static let rock = ImageAsset(name: "pokemonTypeIcons/rock")
    public static let steel = ImageAsset(name: "pokemonTypeIcons/steel")
    public static let water = ImageAsset(name: "pokemonTypeIcons/water")
  }
  public static let purplePokemon = ImageAsset(name: "purple_pokemon")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
