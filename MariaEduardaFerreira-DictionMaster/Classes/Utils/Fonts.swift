import UIKit

struct Fonts {
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "SF-Pro-Rounded-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "SF-Pro-Rounded-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static let regularH1 = Fonts.regular(size: 32)
    static let regularH2 = Fonts.regular(size: 22)
    static let regularH3 = Fonts.regular(size: 18)
    static let regularH4 = Fonts.regular(size: 16)
    
    static let boldH1 = Fonts.bold(size: 45)
    static let boldH2 = Fonts.bold(size: 32)
    static let boldH3 = Fonts.bold(size: 24)
    static let boldH4 = Fonts.bold(size: 22)
    static let boldH5 = Fonts.bold(size: 18)
    static let boldH6 = Fonts.bold(size: 16)
    static let boldH7 = Fonts.bold(size: 20)
}
