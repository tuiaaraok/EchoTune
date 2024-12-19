import Foundation
import SwiftUI

enum CustomFonts: String {
    case commissioner = "Commissioner"
}

struct FontBuilder {
    
    let font: Font
    let tracking: Double
    let lineSpacing: Double
    let verticalPadding: Double
    
    init(
        customFont: CustomFonts,
        fontSize: Double,
        weight: Font.Weight = .regular,
        letterSpacing: Double = 0,
        lineHeight: Double
    ) {
        self.font = Font.custom(customFont, size: fontSize).weight(weight)
        self.tracking = fontSize * letterSpacing
        
        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = self.lineSpacing / 2
    }
    
}

extension FontBuilder {
    
    static let textToggleText = FontBuilder(
        customFont: .commissioner,
        fontSize: 15,
        weight: .bold,
        lineHeight: 18
    )
    
    static let mainTextFieldText = FontBuilder(
        customFont: .commissioner,
        fontSize: 20,
        weight: .regular,
        lineHeight: 24
    )
    
    static let mainTextFieldTitleText = FontBuilder(
        customFont: .commissioner,
        fontSize: 14,
        weight: .regular,
        lineHeight: 17
    )
    
    static let topBarText = FontBuilder(
        customFont: .commissioner,
        fontSize: 22,
        weight: .black,
        lineHeight: 27
    )
    
    static let songViewTitleText = FontBuilder(
        customFont: .commissioner,
        fontSize: 11,
        weight: .medium,
        lineHeight: 15
    )
    
    static let textFieldText = FontBuilder(
        customFont: .commissioner,
        fontSize: 11,
        weight: .medium,
        lineHeight: 15
    )
    
    static let themeToggleText = FontBuilder(
        customFont: .commissioner,
        fontSize: 15,
        weight: .regular,
        lineHeight: 17
    )
    
    static let bottomBarText = FontBuilder(
        customFont: .commissioner,
        fontSize: 14,
        weight: .bold,
        lineHeight: 21
    )
    
    static let addButtonText = FontBuilder(
        customFont: .commissioner,
        fontSize: 20,
        weight: .medium,
        lineHeight: 24
    )
    
    static let mainButtonText = FontBuilder(
        customFont: .commissioner,
        fontSize: 20,
        weight: .bold,
        lineHeight: 24
    )
}

extension Font {
    static func custom(_ fontName: CustomFonts, size: Double) -> Font {
        Font.custom(fontName.rawValue, size: size)
    }
}


@available(iOS 16.0, *)
struct CustomFontsModifire: ViewModifier {
    
    private let fontBuilder: FontBuilder
    
    init(_ fontBuilder: FontBuilder) {
        self.fontBuilder = fontBuilder
    }
    
    func body(content: Content) -> some View {
        content
            .font(fontBuilder.font)
            .lineSpacing(fontBuilder.lineSpacing)
            .padding([.vertical], fontBuilder.verticalPadding)
            .tracking(fontBuilder.tracking)
    }
    
}

@available(iOS 16.0, *)
extension View {
    func customFont(_ fontBuilder: FontBuilder) -> some View {
        modifier(CustomFontsModifire(fontBuilder))
    }
}


