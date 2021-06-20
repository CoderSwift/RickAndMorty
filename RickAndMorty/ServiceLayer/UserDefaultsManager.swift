import Foundation

protocol UserDefaultsManagerProtocol{
    func getSettings() -> FilterUserDefaults
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    
    static let shared = UserDefaultsManager()
    private let defaultFilter = FilterUserDefaults(status: "", gender: "")
    private let key = "filter"
    
    func getSettings () -> FilterUserDefaults {
        
        if let filter = UserDefaults.standard.object(forKey: key) as? FilterUserDefaults{
            return filter
        }
        return defaultFilter
    }
    
}
