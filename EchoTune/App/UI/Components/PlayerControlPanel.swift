import SwiftUI

struct PlayerControlPanel: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject private var player = AudioPlayerManager.shared
    @Binding var songs: [Song]
    
    var body: some View {
        HStack(spacing: 50) {
            
            Button(action: previousTrack) {
                Image(systemName: "backward.end")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.mainAdd)
            }
            
            Button(action: togglePlayPause) {
                Image(systemName: player.isPlaying ? "pause.circle" : "play.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.mainAdd)
                    .padding(10)
            }

            Button(action: nextTrack) {
                Image(systemName: "forward.end")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.mainAdd)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 54)
        .background(Color.addDark)
        .cornerRadius(4)
        .padding(EdgeInsets(top: 0, leading: 27, bottom: 0, trailing: 27))
    }
    
    private func previousTrack() {
        guard let currentIndex = songs.firstIndex(where: { $0.id == player.currentSong?.id }) else { return }
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        player.play(song: songs[previousIndex])
    }

    private func togglePlayPause() {
        if player.isPlaying {
            player.pauseAudio()
        } else {

            if let currentSong = player.currentSong {
                player.audioPlayer?.play()
                player.isPlaying = true
            } else if let firstSong = songs.first {
                player.play(song: firstSong)
            }
        }
    }
    
    private func nextTrack() {
        guard let currentIndex = songs.firstIndex(where: { $0.id == player.currentSong?.id }) else { return }
        let nextIndex = (currentIndex + 1) % songs.count
        player.play(song: songs[nextIndex])
    }
}
