import SwiftUI

enum MainFlowTab {
    case home
    case library
    case artists
    case settings
}

enum AppScreens: Hashable {
    
    case home
    case addSong
    
    case artists
    case addArtist
    case artistDetails(UUID)  
}

@available(iOS 16.0, *)
struct MainFlow: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var currentTab: MainFlowTab = .home
    
    private var buttons: [TabBarButtonConfiguration] {
        [
            TabBarButtonConfiguration(icon: themeManager.isLT ? .homeLight : .homeDark, title: "Home", tab: .home),
            TabBarButtonConfiguration(icon: themeManager.isLT ? .libraryLight : .libraryDark, title: "Library", tab: .library),
            TabBarButtonConfiguration(icon: themeManager.isLT ? .artistsLight : .artistsDark, title: "Artists", tab: .artists),
            TabBarButtonConfiguration(icon: themeManager.isLT ? .settingsLight : .settingsDark, title: "Settings", tab: .settings)
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeFlow()
                    .tag(MainFlowTab.home)
                LibraryFlow()
                    .tag(MainFlowTab.library)
                ArtistsFlow()
                    .tag(MainFlowTab.artists)
                SettingsFlow()
                    .tag(MainFlowTab.settings)
            }
            
            TabBar(currentTab: $currentTab, buttons: buttons)
                
        }
    }
}

@available(iOS 16.0, *)
private struct TabBar: View {
    @Binding var currentTab: MainFlowTab
    let buttons: [TabBarButtonConfiguration]
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(buttons.enumerated()), id: \.element.id) { (index, button) in
                let style: TabBarButtonStyle = button.tab == currentTab
                ? .active
                : .unactive(Color.mainText)
                
                TabBarButton(
                    configuration: button,
                    style: style,
                    action: { currentTab = button.tab }
                )
            }
        }
    }
}

private struct TabBarButtonConfiguration: Identifiable {
    var id: MainFlowTab { tab }
    
    let icon: ImageResource
    let title: String
    let tab: MainFlowTab
}

private struct TabBarButtonStyle {
    let backgroundColor: Color
    
    static let active = TabBarButtonStyle(backgroundColor: Color.mainAdd)
    static func unactive(_ backgroundColor: Color) -> TabBarButtonStyle {
        TabBarButtonStyle(backgroundColor: backgroundColor)
    }
}

@available(iOS 16.0, *)
private struct TabBarButton: View {
    let configuration: TabBarButtonConfiguration
    let style: TabBarButtonStyle
    let action: () -> Void
    
    var body: some View {
        let height = 56.0
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                Image(configuration.icon)
                    .padding(.bottom, 2)
                Text(configuration.title)
                    .customFont(.bottomBarText)
                    .lineLimit(1)
            }
            .foregroundColor(Color.background)
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(style.backgroundColor)
        }
    }
}

