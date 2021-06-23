import Foundation

protocol UserDefaultsManagerProtocol{
    func getFilter() -> FilterUserDefaults
    func setFilter (_ filter: FilterUserDefaults)
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    static let shared = UserDefaultsManager()
    private let defaultFilter = FilterUserDefaults(status: "", gender: "")
    private let key = "filter"
    
    func getFilter () -> FilterUserDefaults {
        if let filter = UserDefaults.standard.object(forKey: key) as? FilterUserDefaults{
            return filter
        }
        return defaultFilter
    }
    
    func setFilter (_ filter: FilterUserDefaults) {
        UserDefaults.standard.set(encodable: filter, forKey: key)
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
}
