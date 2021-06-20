import Foundation

struct CharactersData: Decodable {
    var info: CharactersInfo?
    var results: [CharactersResult]?
}

struct CharactersInfo:Decodable {
    var pages: Int?
}

struct CharactersResult:Decodable {
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var location: Location?
    var image: String?
    var episode: [String]?
}

struct Location: Decodable {
    var name: String?
    var url: String?
}

enum CharactersResultType: String {
    case name = "Name"
    case status = "Status"
    case species = "Species"
    case gender = "Gender"
}

enum Status:String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    static let allStatus = [alive, dead, unknown]

    func ordinal() -> Int{
        return Status.allStatus.firstIndex(of: self)!
    }
}

enum Gender:String {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "Unknown"
    static let allGender = [female, male, genderless, unknown]

    func ordinal() -> Int{
        return Gender.allGender.firstIndex(of: self)!
    }
}

