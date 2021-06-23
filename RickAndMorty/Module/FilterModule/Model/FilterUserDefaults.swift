import Foundation

class FilterUserDefaults: Codable {
    var status: String
    var gender: String
    
    init(status:String, gender:String) {
        self.status = status
        self.gender = gender
    }
    
    public enum CodingKeys: String, CodingKey {
        case status, gender
    }

}
