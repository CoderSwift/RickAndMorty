import Foundation

struct EpisodeData:Decodable {
    var info: EpisodeInfo?
    var results: [EpisodeResult]?
}

struct EpisodeInfo:Decodable {
    var pages: Int?
}

struct EpisodeResult:Decodable {
    var name: String?
    var air_date: String?
    var episode: String?
}


