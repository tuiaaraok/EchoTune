import SwiftUI

@available(iOS 16.0, *)
struct HomeFlow: View {
    @State var navigationPath: [AppScreens] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            HomeScreen(navigationPath: $navigationPath)
                .navigationDestination(for: AppScreens.self) { screen in
                    switch screen {
                    case .home:
                        HomeScreen(navigationPath: $navigationPath)
                    case .addSong:
                        AddSongScreen(navigationPath: $navigationPath)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}


