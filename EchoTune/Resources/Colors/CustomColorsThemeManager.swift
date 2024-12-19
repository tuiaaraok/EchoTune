import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @AppStorage("isLightTheme") var isLT: Bool = true
    
    private init() {}
}

extension Color {
    
    static var mainTextFieldBackground: Color {
        .addLight
    }
    
    static var toggleBackground: Color {
        ThemeManager.shared.isLT ? .addLight : .addDark
    }
    
    static var tabBarBackground: Color {
        ThemeManager.shared.isLT ? .black : .white
    }
    
    static var mainAdd: Color {
        ThemeManager.shared.isLT ? .mainLight : .mainDark
    }

    static var mainText: Color {
        ThemeManager.shared.isLT ? .black : .white
    }
    
    static var background: Color {
        ThemeManager.shared.isLT ? .white : .black
    }
}




