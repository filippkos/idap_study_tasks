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
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Colors {
  public enum Colors {
    public static let abbey = ColorAsset(name: "colors/abbey")
    public static let corn = ColorAsset(name: "colors/corn")
    public static let gold = ColorAsset(name: "colors/gold")
    public static let heather = ColorAsset(name: "colors/heather")
    public static let wildSand = ColorAsset(name: "colors/wild_sand")
  }
  public enum PokemonTypesBgColors {
    public static let bug = ColorAsset(name: "pokemonTypesBgColors/bug")
    public static let dark = ColorAsset(name: "pokemonTypesBgColors/dark")
    public static let dragon = ColorAsset(name: "pokemonTypesBgColors/dragon")
    public static let electric = ColorAsset(name: "pokemonTypesBgColors/electric")
    public static let fairy = ColorAsset(name: "pokemonTypesBgColors/fairy")
    public static let fighting = ColorAsset(name: "pokemonTypesBgColors/fighting")
    public static let fire = ColorAsset(name: "pokemonTypesBgColors/fire")
    public static let flying = ColorAsset(name: "pokemonTypesBgColors/flying")
    public static let ghost = ColorAsset(name: "pokemonTypesBgColors/ghost")
    public static let grass = ColorAsset(name: "pokemonTypesBgColors/grass")
    public static let ground = ColorAsset(name: "pokemonTypesBgColors/ground")
    public static let icy = ColorAsset(name: "pokemonTypesBgColors/icy")
    public static let normal = ColorAsset(name: "pokemonTypesBgColors/normal")
    public static let poison = ColorAsset(name: "pokemonTypesBgColors/poison")
    public static let psychic = ColorAsset(name: "pokemonTypesBgColors/psychic")
    public static let rock = ColorAsset(name: "pokemonTypesBgColors/rock")
    public static let steel = ColorAsset(name: "pokemonTypesBgColors/steel")
    public static let water = ColorAsset(name: "pokemonTypesBgColors/water")
  }
  public enum PokemonTypesMainColors {
    public static let bug = ColorAsset(name: "pokemonTypesMainColors/bug")
    public static let dark = ColorAsset(name: "pokemonTypesMainColors/dark")
    public static let dragon = ColorAsset(name: "pokemonTypesMainColors/dragon")
    public static let electric = ColorAsset(name: "pokemonTypesMainColors/electric")
    public static let fairy = ColorAsset(name: "pokemonTypesMainColors/fairy")
    public static let fighting = ColorAsset(name: "pokemonTypesMainColors/fighting")
    public static let fire = ColorAsset(name: "pokemonTypesMainColors/fire")
    public static let flying = ColorAsset(name: "pokemonTypesMainColors/flying")
    public static let ghost = ColorAsset(name: "pokemonTypesMainColors/ghost")
    public static let grass = ColorAsset(name: "pokemonTypesMainColors/grass")
    public static let ground = ColorAsset(name: "pokemonTypesMainColors/ground")
    public static let icy = ColorAsset(name: "pokemonTypesMainColors/icy")
    public static let normal = ColorAsset(name: "pokemonTypesMainColors/normal")
    public static let poison = ColorAsset(name: "pokemonTypesMainColors/poison")
    public static let psychic = ColorAsset(name: "pokemonTypesMainColors/psychic")
    public static let rock = ColorAsset(name: "pokemonTypesMainColors/rock")
    public static let steel = ColorAsset(name: "pokemonTypesMainColors/steel")
    public static let water = ColorAsset(name: "pokemonTypesMainColors/water")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
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
