import Foundation

struct LocationsData {
    var info: LocationsInfo?
    var results: LocationsResult?
}

struct LocationsInfo {
    var page: Int?
}

struct LocationsResult {
    var name: String?
    var type: String?
    var dimension: String?
}

enum LocationsResultType: String {
    case name = "Name"
    case type = "Type"
    case dimension = "Dimension"
}
