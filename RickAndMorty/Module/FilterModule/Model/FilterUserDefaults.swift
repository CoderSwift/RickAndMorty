
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.gender, forKey: .gender)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try (container.decodeIfPresent(String.self, forKey: .status) ?? "status")
        self.gender = try (container.decodeIfPresent(String.self, forKey: .gender) ?? "gender")
        
    }
    
}
