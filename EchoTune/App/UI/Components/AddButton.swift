import SwiftUI

@available(iOS 16.0, *)
struct AddButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                Text(title)
                    .customFont(.addButtonText)
                    .foregroundStyle(Color.mainText)
                Image(themeManager.isLT == true ? "plusButtonLightIcon" : "plusButtonDarkIcon")
                    .frame(width: 34, height: 34)
            }.frame(maxWidth: .infinity, maxHeight: 34)
                .padding(.top, 44)
        }
    }
}
