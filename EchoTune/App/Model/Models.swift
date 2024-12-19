import Foundation

struct Song: Identifiable, Codable {
    let id: UUID
    
    let name: String
    
    var trackURL: URL
    let artist: String
    let genre: String
    let coverURL: URL?
    
    
    init(id: UUID = UUID(), name: String, trackURL: URL, artist: String, genre: String, coverURL: URL?) {
        self.id = id
        
        self.name = name
        
        self.trackURL = trackURL
        self.artist = artist
        self.genre = genre
        self.coverURL = coverURL
    }
}

struct Artist: Identifiable, Codable {
    let id: UUID
    
    let isSolo: Bool
    
    var name: String
    
    var genre: String
    
    var vocalistName: String
    var drummerName: String
    var guitaristName: String
    var groupPersons: [GroupPerson]
    
    init(id: UUID = UUID(), isSolo: Bool, name: String, genre: String, vocalistName: String, drummerName: String, guitaristName: String, groupPersons: [GroupPerson]) {
        self.id = id
        
        self.isSolo = isSolo
        
        self.name = name
        
        self.genre = genre
        
        self.vocalistName = vocalistName
        self.drummerName = drummerName
        self.guitaristName = guitaristName
        self.groupPersons = groupPersons
        
    }
}

struct GroupPerson: Identifiable, Codable {
    let id: UUID
    
    var role: String
    var name: String
    
    init(id: UUID = UUID(), role: String, name: String) {
        self.id = id
        
        self.role = role
        self.name = name
    }
}

struct Playlist: Identifiable, Codable {
    let id: UUID
    var name: String
    var songs: [Song]
    
    init(id: UUID = UUID(), name: String, songs: [Song] = []) {
        self.id = id
        self.name = name
        self.songs = songs
    }
}
struct ObjectWithNameOnly: Identifiable, Codable, Hashable {
    let id: UUID
    
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        
        self.name = name
    }
}

