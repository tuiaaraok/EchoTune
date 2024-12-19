import SwiftUI

@available(iOS 16.0, *)
struct MainTextField: View {
    @EnvironmentObject var themeManager: ThemeManager
    var title: String
    @Binding var text: String
    var placeholder: String = ""
    var axis: Axis = .horizontal
    var keyboardType: UIKeyboardType = .default
    var titleTextColor: Color = Color.mainText
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .customFont(.mainTextFieldTitleText)
                .foregroundStyle(titleTextColor)
            TextField(text: $text, axis: axis) {
                Text(placeholder)
                    .customFont(.mainTextFieldText)
                    .foregroundStyle(Color.mainAdd)
                    .keyboardType(keyboardType)
            }
            .customFont(.mainTextFieldText)
            .foregroundStyle(Color.mainAdd)
            .padding(11)
            .background(Color.mainTextFieldBackground)
            .frame(maxHeight: 42)
            .cornerRadius(6)
            
        }
    }
}
