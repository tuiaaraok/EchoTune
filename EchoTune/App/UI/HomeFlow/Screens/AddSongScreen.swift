import SwiftUI

@available(iOS 16.0, *)
struct AddSongScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var navigationPath: [AppScreens]
    
    @State private var trackName: String = ""
    @State private var trackURL: URL? = nil
    @State private var artist: String = ""
    @State private var genre: String = ""
    @State private var coverURL: URL? = nil
    
    @State private var uploadedTrackName = ""
    @State private var uploadedCoverName = ""
    
    @State private var showingTrackPicker = false
    @State private var showingCoverPicker = false
    @State private var isMenuVisible = false
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {

            TopBarView(title: "Add song", navigationPath: $navigationPath)
            
            VStack(spacing: 15) {
                MainTextField(title: "Enter track name", text: $trackName)
                TrackSelectionView(title: "Upload track", uploadedTrackName: $uploadedTrackName, showingPicker: $showingTrackPicker)
                MainTextField(title: "Group/Artist", text: $artist)
                
                GenreSelectionView(title: "Genre", genre: $genre, isMenuVisible: $isMenuVisible)
                
                if isMenuVisible {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(Storage.genresObjects) { genresObjects in
                                Button(action: {
                                    genre = genresObjects.name
                                    isMenuVisible = false
                                }) {
                                    Text(genresObjects.name)
                                        .customFont(.textFieldText)
                                        .foregroundColor(Color.mainText)
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                }
                                Divider()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .background(Color.background)
                    .cornerRadius(6)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxHeight: 200)
                }
                
                TrackSelectionView(title: "Upload song cover", uploadedTrackName: $uploadedCoverName, showingPicker: $showingCoverPicker)
            }.padding(EdgeInsets(top: 55, leading: 32, bottom: 0, trailing: 32))
            

            
            Spacer()
            
            MainButton(text: "Save", action: saveSongAndExit)
                .padding(.bottom, 2)
            
        }
        .sheet(isPresented: $showingTrackPicker) {
            DocumentPicker { selectedURL in
                trackURL = selectedURL
                uploadedTrackName = selectedURL.lastPathComponent
            }
        }
        .sheet(isPresented: $showingCoverPicker) {
            DocumentPicker { selectedURL in
                coverURL = selectedURL
                uploadedCoverName = selectedURL.lastPathComponent
            }
        }
        .background(Color.background .ignoresSafeArea())
    }
        
    private func saveSongAndExit() {
        if let trackURL = trackURL {
            let song = Song(name: trackName, trackURL: trackURL, artist: artist, genre: genre, coverURL: coverURL)
            storage.saveSong(song)
            if !navigationPath.isEmpty {
                navigationPath.removeLast()
            }
        }
    }
}

@available(iOS 16.0, *)
private struct TrackSelectionView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    @Binding var uploadedTrackName: String
    @Binding var showingPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .customFont(.mainTextFieldTitleText)
                .foregroundStyle(Color.mainText)
            Button(action: { showingPicker = true }) {
                HStack(spacing: 0) {
                    Text(uploadedTrackName.isEmpty ? "MMM" : uploadedTrackName)
                        .customFont(.mainTextFieldText)
                        .foregroundStyle(uploadedTrackName.isEmpty ? Color.mainAdd.opacity(0.0) : Color.mainAdd)
                        .padding(11)
                        
                    Spacer()
                    Image(systemName: "arrow.down.circle.dotted")
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




