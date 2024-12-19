import SwiftUI

@available(iOS 16.0, *)
struct SearchBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var name: String
    var searchAction: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(text: $name) {
                HStack(spacing: 16) {
                    Text("Search..")
                        .customFont(.textFieldText)
                        .foregroundStyle(Color.gray)
                }
            }
            .foregroundStyle(Color.mainText)
            .customFont(.textFieldText)
            .padding(EdgeInsets(top: 14, leading: 50, bottom: 15, trailing: 19))
            .frame(maxHeight: 32)
            .background(Color.background)
            .cornerRadius(20)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                        .padding(.leading, 14)
                    Spacer()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.mainText, lineWidth: 1)
            )
            
            Button(action: searchAction) {
                Text("Search")
                    .customFont(.textFieldText)
                    .padding(14)
                    .foregroundStyle(Color.mainText)
                    .frame(maxHeight: 32)
                    .background(Color.mainAdd)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.mainText, lineWidth: 1)
                    )
            }
        }
        .padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 40))
    }
}
