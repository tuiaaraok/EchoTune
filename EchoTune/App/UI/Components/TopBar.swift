import SwiftUI

@available(iOS 16.0, *)
struct TopBarView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let title: String
    @Binding var navigationPath: [AppScreens]
    
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                BackButton(navigationPath: $navigationPath)
                Spacer()
            }.padding(.leading, 22)
            
            Text(title)
                .customFont(.topBarText)
                .foregroundStyle(Color.mainText)
            
        }
        .padding(.top, 40)
    }
}

struct BackButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var navigationPath: [AppScreens]
    
    var body: some View {
        Button(action: {
            if !navigationPath.isEmpty {
                navigationPath.removeLast()
            }
        }) {
            Image(systemName: "chevron.left")

                .foregroundStyle(Color.mainText)
        }
        .navigationBarBackButtonHidden(true)
    }
}
