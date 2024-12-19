import SwiftUI
import AVFoundation

class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()

    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentSong: Song?

    private init() {}

    func play(song: Song) {
        stopAudio()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: song.trackURL)
            audioPlayer?.play()
            currentSong = song
            isPlaying = true
        } catch {
            print("Ошибка воспроизведения: \(error)")
        }
    }

    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    var onDocumentPicked: (URL) -> Void

    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(onDocumentPicked: onDocumentPicked)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    var onDocumentPicked: (URL) -> Void

    init(onDocumentPicked: @escaping (URL) -> Void) {
        self.onDocumentPicked = onDocumentPicked
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            onDocumentPicked(url)
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
