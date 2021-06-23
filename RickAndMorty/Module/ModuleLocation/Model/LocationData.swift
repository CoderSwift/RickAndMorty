import Foundation

struct LocationsData:Decodable {
    var info: LocationsInfo?
    var results: [LocationsResult]?
}

struct LocationsInfo:Decodable {
    var pages: Int?
}

struct LocationsResult:Decodable {
    var name: String?
    var type: String?
    var dimension: String?
}

enum LocationsResultType: String {
    case name = "Name"
    case type = "Type"
    case dimension = "Dimension"
}
