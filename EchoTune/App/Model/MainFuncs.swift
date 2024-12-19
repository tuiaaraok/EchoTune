import SwiftUI
import AVFoundation

func loadTrackDuration(_ song: Song) -> String {
    var duration = "00:00"
    do {
        let audioPlayer = try AVAudioPlayer(contentsOf: song.trackURL)
        let totalSeconds = Int(audioPlayer.duration)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        duration = String(format: "%02d:%02d", minutes, seconds)
    } catch {
        print("Ошибка загрузки трека: \(error)")
    }
    return duration
}
