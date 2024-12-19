import SwiftUI

@available(iOS 16.0, *)
struct ToggleView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isSmth: Bool
    var positiveButtonLabel: String
    var negativeButtonLabel: String
    var veticalTextPaddings: CGFloat = 12
    
    var body: some View {
        HStack(spacing: 2) {
            Button(action: {
                isSmth = true
            }) {
                Text(positiveButtonLabel)
                    .customFont(.textToggleText)
                    .frame(maxWidth: .infinity)
                    .padding(veticalTextPaddings)
                    .underline(color: (isSmth == true ? Color.mainAdd: Color.mainAdd.opacity(0.0)))
                    .foregroundColor(Color.mainText)
            }
            
            Button(action: {
                isSmth = false
            }) {
                Text(negativeButtonLabel)
                    .customFont(.textToggleText)
                    .frame(maxWidth: .infinity)
                    .padding(veticalTextPaddings)
                    .underline(color: (isSmth == false ? Color.mainAdd: Color.mainAdd.opacity(0.0)))
                    .foregroundColor(Color.mainText)
            }
        }
        .frame(maxWidth: 150)
        .padding(.top, 9)
    }
}

