import SwiftUI

@available(iOS 16.0, *)
struct GenreSelectionView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    @Binding var genre: String
    @Binding var isMenuVisible: Bool
    
    var body: some View {

        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .customFont(.mainTextFieldTitleText)
                .foregroundStyle(Color.mainText)
            Button(action: {
                withAnimation {
                    isMenuVisible.toggle()
                }
            }) {
                HStack(spacing: 0) {
                    Text(genre.isEmpty ? "MMM" : genre)
                        .customFont(.mainTextFieldText)
                        .foregroundStyle(genre.isEmpty ? Color.mainAdd.opacity(0.0) : Color.mainAdd)
                        .padding(11)
                        
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color.mainAdd)
                        .padding(.trailing, 6)
                }
                .background(Color.mainTextFieldBackground)
                .frame(maxHeight: 42)
                .cornerRadius(6)
            }
        }
    }
}
