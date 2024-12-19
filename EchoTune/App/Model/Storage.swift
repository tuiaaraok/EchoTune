import SwiftUI

class Storage {
    
    static let shared = Storage()
    
    private let songsKey = "songs"
    private let artistKey = "artists"
    private let playlistsKey = "playlists"
    
    private init() {  }
    
    let appId = "6739531002"
    let privacyPolicyUrl = "https://docs.google.com/document/d/1rvsrHBVyPDNJ2_p1JzhOsJcHkJwiv5YmPVANsv6PuBo/mobilebasic"
    let email = "emrekelek97@icloud.com"
    
    func savePlaylist(_ playlist: Playlist) {
        var playlists = getPlaylists()
        playlists.append(playlist)
        savePlaylists(playlists)
    }
    
    func savePlaylists(_ playlists: [Playlist]) {
        if let data = try? JSONEncoder().encode(playlists) {
            UserDefaults.standard.set(data, forKey: playlistsKey)
        }
    }
    
    func getPlaylists() -> [Playlist] {
        guard let data = UserDefaults.standard.data(forKey: playlistsKey),
              let playlists = try? JSONDecoder().decode([Playlist].self, from: data) else {
            return []
        }
        return playlists
    }
    
    func getPlaylistsByName(_ name: String) -> [Playlist] {
        return getPlaylists().filter { $0.name.lowercased().contains(name.lowercased()) }
    }
    
    func updatePlaylist(_ updatedPlaylist: Playlist) {
        var playlists = getPlaylists()
        if let index = playlists.firstIndex(where: { $0.id == updatedPlaylist.id }) {
            playlists[index] = updatedPlaylist
            savePlaylists(playlists)
        }
    }
    
    func saveArtist(_ artist: Artist) {
        var artists = getArtists()
        artists.append(artist)
        saveArtists(artists)
    }
    
    func saveArtists(_ artists: [Artist]) {
        if let data = try? JSONEncoder().encode(artists) {
            UserDefaults.standard.set(data, forKey: artistKey)
        }
    }
    
    func getArtistById(_ id: UUID) -> Artist? {
        return getArtists().filter { $0.id == id }.first
    }
    
    
    func getArtistByName(_ name: String) -> [Artist] {
        return getArtists().filter { $0.name.lowercased().contains(name.lowercased()) }
    }
    
    func getArtists() -> [Artist] {
        guard let data = UserDefaults.standard.data(forKey: artistKey),
              let artists = try? JSONDecoder().decode([Artist].self, from: data) else {
            return []
        }
        return artists
    }
    
    func saveSong(_ song: Song) {
        var songs = getSongs()
        songs.append(song)
        saveSongs(songs)
    }
    
    func saveSongs(_ songs: [Song]) {
        if let data = try? JSONEncoder().encode(songs) {
            UserDefaults.standard.set(data, forKey: songsKey)
        }
    }
    
    func getSongsByName(_ name: String) -> [Song] {
        return getSongs().filter { $0.name.lowercased().contains(name.lowercased()) }
    }
    
    func getSongs() -> [Song] {
        guard let data = UserDefaults.standard.data(forKey: songsKey),
              let songs = try? JSONDecoder().decode([Song].self, from: data) else {
            return []
        }
        return songs
    }
    
    static let genresObjects: [ObjectWithNameOnly] = [
        ObjectWithNameOnly(name: "Pop"),
        ObjectWithNameOnly(name: "Rock"),
        ObjectWithNameOnly(name: "Hip Hop"),
        ObjectWithNameOnly(name: "Jazz"),
        ObjectWithNameOnly(name: "Classical"),
        ObjectWithNameOnly(name: "Electronic"),
        ObjectWithNameOnly(name: "Reggae"),
        ObjectWithNameOnly(name: "Blues"),
        ObjectWithNameOnly(name: "Country"),
        ObjectWithNameOnly(name: "R&B"),
        ObjectWithNameOnly(name: "Metal"),
        ObjectWithNameOnly(name: "Punk"),
        ObjectWithNameOnly(name: "Folk"),
        ObjectWithNameOnly(name: "Soul"),
        ObjectWithNameOnly(name: "Disco"),
        ObjectWithNameOnly(name: "Ska"),
        ObjectWithNameOnly(name: "Alternative Rock"),
        ObjectWithNameOnly(name: "Latin"),
        ObjectWithNameOnly(name: "Indie"),
        ObjectWithNameOnly(name: "Gospel")
    ]
}

