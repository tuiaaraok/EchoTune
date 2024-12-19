import SwiftUI

@available(iOS 16.0, *)
struct MainButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Text(text)
                    .customFont(.mainButtonText)
                    .foregroundStyle(Color.mainText)
                    .padding(15)
            }
            .frame(maxWidth: .infinity, maxHeight: 54)
            .background(Color.mainAdd)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0, leading: 27, bottom: 0, trailing: 27))
            
        }
    }
}
