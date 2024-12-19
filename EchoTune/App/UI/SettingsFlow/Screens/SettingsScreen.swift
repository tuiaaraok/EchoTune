import SwiftUI

@available(iOS 16.0, *)
struct SettingsScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    private let storage = Storage.shared
    var body: some View {
        VStack(spacing: 0) {
            Text(themeManager.isLT == true ? "Dark Mode" : "Light Mode")
                .customFont(.themeToggleText)
                .foregroundStyle(Color.mainText)
                .padding(.top, 200)
            
            ThemeToggle()
                .padding(.top, 15)
            
            VStack(spacing: 23) {
                MainButton(text: "Contact us", action: { sendEmail(storage.email) })
                MainButton(text: "Privacy Policy", action: { openPrivacy(storage.privacyPolicyUrl) })
                MainButton(text: "Rate us", action: { openRate(storage.appId) })
            }.padding(.top, 94)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background).ignoresSafeArea()
    }
    
    func openRate(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openPrivacy(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func sendEmail(_ email: String) {
        if let url = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

private struct ThemeToggle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Toggle(isOn: $themeManager.isLT) {}
            .toggleStyle(CustomToggleStyle())
    }
}

private struct CustomToggleStyle: ToggleStyle {
    @EnvironmentObject var themeManager: ThemeManager
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.toggleBackground)
                .frame(width: 50, height: 25)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(3)
                        .shadow(color: Color.black, radius: 2, x: configuration.isOn ? -1 : 1, y: 1)
                        .offset(x: configuration.isOn ? 12 : -12)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
