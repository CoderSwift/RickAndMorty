import UIKit

protocol Builder{
    static func createLaunch() -> UIViewController
    static func createMain() -> UIViewController
    static func createChartacter() -> UIViewController
    static func createDetailCharacter(dataCharacter: CharactersResult?) -> UIViewController
    static func createLocation() -> UIViewController
    static func createEpisode() -> UIViewController
    static func createFilter(parentPresent: CharacterPresenterProtocol?) -> UIViewController
}

class ModuleBuilder:Builder {
    static func createLaunch() -> UIViewController {
        let view = LaunchViewController()
        let presenter = LaunchPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let model = [
            NavigationInfo(title: "Characters", image: "image-navigation-1"),
            NavigationInfo(title: "Locations", image: "image-navigation-2"),
            NavigationInfo(title: "Episodes", image: "image-navigation-3")
        ]
        let presenter = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view 
    }
    
    static func createChartacter() -> UIViewController {
        let view = CharacterViewController()
        let networkManager = NetworkManager()
        let presenter = CharacterPresenter(view: view,  networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createDetailCharacter(dataCharacter: CharactersResult?) -> UIViewController {
        let view = DetailCharacterViewController()
        let presenter = DetailCharacterPresenter(view: view, model: dataCharacter!)
        view.presenter = presenter
        return view
    }
    
    static func createLocation() -> UIViewController {
        let view = LocationViewController()
        let networkManager = NetworkManager()
        let presenter = LocationPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createEpisode() -> UIViewController {
        let view = EpisodeViewController()
        let networkManager = NetworkManager()
        let presenter = EpisodePresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createFilter(parentPresent: CharacterPresenterProtocol?) -> UIViewController {
        let view = FilterViewController()
        let presenter = FilterPresenter(view: view)
        view.presenter = presenter
        view.parentPresent = parentPresent
        return view
    }
}
