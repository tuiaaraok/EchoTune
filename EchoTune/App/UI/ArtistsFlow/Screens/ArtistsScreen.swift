import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct ArtistsScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var navigationPath: [AppScreens]
    
    @State private var artists: [Artist] = [Artist(isSolo: true, name: "Henry Rollins", genre: "", vocalistName: "", drummerName: "", guitaristName: "", groupPersons: [])]
    @State private var name = ""
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(name: $name) {
                name.isEmpty ? getArtists() : getArtistByName()
            }
            
            AddButton(title: "Add group") {
                navigationPath.append(AppScreens.addArtist)
            }
            
            List {
                ForEach(artists) { artist in
                    ArtistsView(
                        name: artist.name,
                        showButtonAction: { showArtistDetails(artist) }
                    ).listRowBackground(Color.background)
                }
                .onDelete { indexSet in
                    artists.remove(atOffsets: indexSet)
                    storage.saveArtists(artists)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(.top, 44)
        }
        .onAppear { getArtists() }
        .background(Color.background.ignoresSafeArea())
    }
    
    
    private func showArtistDetails(_ artist: Artist) {
        navigationPath.append(AppScreens.artistDetails(artist.id))
    }
    private func getArtists() {
        artists = storage.getArtists()
    }
    private func getArtistByName() {
        artists = storage.getArtistByName(name)
    }
}


@available(iOS 16.0, *)
private struct ArtistsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let name: String
    let showButtonAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(name)
                .customFont(.songViewTitleText)
                .foregroundStyle(Color.mainText)
                .padding(.leading, 6)
            Spacer()
            
            Button(action: showButtonAction) {
                Image(systemName: "eye.circle")
                    .foregroundStyle(Color.mainText)
            }
            .buttonStyle(.plain)
        }
        .background(Color.background)
    }
}
