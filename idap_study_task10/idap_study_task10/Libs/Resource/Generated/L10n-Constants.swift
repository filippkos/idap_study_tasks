// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Dashboard {
    /// Localizable.strings
    ///   idap_study_task10
    /// 
    ///   Created by Filipp Kosenko on 07.03.2023.
    public static let buttonTitle = L10n.tr("Localizable", "dashboard.button_title", fallback: "GO!")
    public enum First {
      /// IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.
      public static let description = L10n.tr("Localizable", "dashboard.first.description", fallback: "IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.")
      /// Find out who
      public static let title = L10n.tr("Localizable", "dashboard.first.title", fallback: "Find out who")
    }
    public enum Second {
      /// IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.
      public static let description = L10n.tr("Localizable", "dashboard.second.description", fallback: "IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.")
      /// Find out about the abilities
      public static let title = L10n.tr("Localizable", "dashboard.second.title", fallback: "Find out about the abilities")
    }
    public enum Third {
      /// IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.
      public static let description = L10n.tr("Localizable", "dashboard.third.description", fallback: "IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some.")
      /// Collect them all
      public static let title = L10n.tr("Localizable", "dashboard.third.title", fallback: "Collect them all")
    }
  }
  public enum PokemonList {
    /// Nothing was found for your query, try changing the search value.
    public static let emptySearchResultMessage = L10n.tr("Localizable", "pokemon_list.empty_search_result_message", fallback: "Nothing was found for your query, try changing the search value.")
    /// All pokemon
    public static let title = L10n.tr("Localizable", "pokemon_list.title", fallback: "All pokemon")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
