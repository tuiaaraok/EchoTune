import SwiftUI

@available(iOS 16.0, *)
struct LibraryScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var playlists: [Playlist] = []
    @State private var isCreatingNewPlaylist = false
    @State private var newPlaylistName = ""
    @State private var selectedPlaylist: Playlist? = nil
    @State private var searchPlayListName: String = ""
    
    private let storage = Storage.shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                SearchBar(name: $searchPlayListName) {
                    searchPlayListName.isEmpty ? loadPlaylists() : loadPlaylistsByName()
                }
                
                AddButton(title: "Create playlist") {
                    isCreatingNewPlaylist = true
                }
                
                List {
                    ForEach(playlists) { playlist in
                        NavigationLink(destination: PlaylistDetailScreen(playlist: playlist)) {
                            Text(playlist.name)
                        }.listRowBackground(Color.background)
                    }
                    .onDelete(perform: deletePlaylist)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .padding(.top, 44)
                
                Spacer()
            }
            .background(Color.background.ignoresSafeArea())
            .sheet(isPresented: $isCreatingNewPlaylist) {
                VStack(spacing: 0) {
                    
                    MainTextField(title: "New playlist", text: $newPlaylistName, placeholder: "Enter playlist name", titleTextColor: Color.mainAdd)
                    
                    HStack(spacing: 30) {
                        Button("Cancel") {
                            isCreatingNewPlaylist = false
                            newPlaylistName = ""
                        }
                        .foregroundColor(Color.red)
                        .padding()
                        
                        Button("Create") {
                            createNewPlaylist()
                        }
                        .foregroundColor(Color.mainAdd)
                        .padding()
                    }
                    .presentationDetents([.medium, .fraction(0.2)])
                }.padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
            }
            .onAppear { loadPlaylists() }
        }
    }
    
    private func loadPlaylistsByName() {
        playlists = storage.getPlaylistsByName(searchPlayListName)
    }
    
    private func loadPlaylists() {
        playlists = storage.getPlaylists()
    }
    
    private func createNewPlaylist() {
        guard !newPlaylistName.isEmpty else { return }
        let newPlaylist = Playlist(name: newPlaylistName)
        storage.savePlaylist(newPlaylist)
        newPlaylistName = ""
        isCreatingNewPlaylist = false
        loadPlaylists()
    }
    
    private func deletePlaylist(at offsets: IndexSet) {
        var updatedPlaylists = playlists
        updatedPlaylists.remove(atOffsets: offsets)
        storage.savePlaylists(updatedPlaylists)
        loadPlaylists()
    }
}

@available(iOS 16.0, *)
struct PlaylistDetailScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var playlist: Playlist
    @State private var availableSongs: [Song] = []
    @State private var selectedSong: Song? = nil
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack {
            LibraryTopBarView(title: playlist.name)
            AddButton(title: "Add song") {
                addSongToPlaylist()
            }
            List {
                ForEach(playlist.songs) { song in
                    HStack {
                        Text(song.name)
                        Spacer()
                        Text(song.artist)
                            .foregroundColor(.gray)
                    }.listRowBackground(Color.background)
                }
            }
            
            Spacer()
        }
        .background(Color.background.ignoresSafeArea())
        .onAppear {
            availableSongs = storage.getSongs()
        }
    }
    
    private func addSongToPlaylist() {
        guard let song = availableSongs.first else { return }
        playlist.songs.append(song)
        storage.updatePlaylist(playlist)
    }
}

@available(iOS 16.0, *)
struct LibraryTopBarView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let title: String
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                LibraryBackButton()
                Spacer()
            }.padding(.leading, 22)
            
            Text(title)
                .customFont(.topBarText)
                .foregroundStyle(Color.mainText)
            
        }
        .padding(.top, 40)
    }
}

struct LibraryBackButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
            
                .foregroundStyle(Color.mainText)
        }
        .navigationBarBackButtonHidden(true)
    }
}


