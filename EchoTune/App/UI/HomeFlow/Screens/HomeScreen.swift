import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct HomeScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var navigationPath: [AppScreens]
    
    @State private var songs: [Song] = []
    @State private var name = ""
    
    private let storage = Storage.shared
    private let player = AudioPlayerManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(name: $name) {
                name.isEmpty ? getSongs() : getSongByName()
            }
            
            AddButton(title: "Add song") {
                navigationPath.append(AppScreens.addSong)
            }
            
            List {
                ForEach(songs) { song in
                    SongView(
                        song: song,
                        playButtonAction: { playSong(song) }
                    ).listRowBackground(Color.background)
                }
                .onDelete { indexSet in
                    songs.remove(atOffsets: indexSet)
                    storage.saveSongs(songs)
                }
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(.top, 44)
            
            PlayerControlPanel(songs: $songs)                
        }
        .onAppear { getSongs() }
        .background(Color.background.ignoresSafeArea())
    }
    
    private func getSongByName() {
        songs = storage.getSongsByName(name)
    }
    
    private func getSongs() {
        songs = storage.getSongs()
    }
    
    private func playSong(_ song: Song) {
        if player.isPlaying, player.currentSong?.id == song.id {
            player.pauseAudio()
        } else {
            player.play(song: song)
        }
    }
}


@available(iOS 16.0, *)
private struct SongView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject private var player = AudioPlayerManager.shared
    let song: Song
    let playButtonAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Image("stubIcon")
                .frame(width: 28, height: 28)
            VStack(alignment: .leading, spacing: 1) {
                Text(song.name)
                Text(loadTrackDuration(song))
            }
            .customFont(.songViewTitleText)
            .foregroundStyle(Color.mainText)
            .padding(.leading, 6)
            Spacer()
            
            Button(action: playButtonAction) {
                Image(systemName: player.currentSong?.id == song.id && player.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundStyle(Color.mainText)
            }
            .buttonStyle(.plain)
        }
        .background(Color.background)
    }
}
