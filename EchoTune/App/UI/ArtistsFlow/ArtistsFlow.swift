import SwiftUI

@available(iOS 16.0, *)
struct ArtistsFlow: View {
    @State var navigationPath: [AppScreens] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ArtistsScreen(navigationPath: $navigationPath)
                .navigationDestination(for: AppScreens.self) { screen in
                    switch screen {
                    case .artists:
                        ArtistsScreen(navigationPath: $navigationPath)
                    case .addArtist:
                        AddArtistScreen(navigationPath: $navigationPath)
                    case .artistDetails(let id):
                        ArtistDetailsScreen(navigationPath: $navigationPath, id: id)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}



