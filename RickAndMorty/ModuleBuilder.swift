//
//  ModuleBuilder.swift
//  RickAndMorty
//
//  Created by coder on 28.05.21.
//

import UIKit


protocol Builder{
    static func createLaunch() -> UIViewController
    static func createMain() -> UIViewController
    static func createChartacter() -> UIViewController
    static func createDetailCharacter(dataCharacter: CharactersResult?) -> UIViewController
    static func createFilter(delegateByFilter: CharacterViewController?) -> UIViewController
    static func createLocation() -> UIViewController
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
    
    static func createLocation() -> UIViewController {
        let view = LocationViewController()
        let networkManager = NetworkManager()
        let presenter = LocationPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createChartacter() -> UIViewController {
        let view = CharacterViewController()
        let networkManager = NetworkManager()
        let userDefaultsManager = UserDefaultsManager()
        let presenter = CharacterPresenter(view: view, userDefaultsManager: userDefaultsManager,   networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createDetailCharacter(dataCharacter: CharactersResult?) -> UIViewController {
        let view = DetailCharacterViewController()
        let presenter = DetailCharacterPresenter(view: view, model: dataCharacter!)
        view.presenter = presenter
        return view
    }
    
    static func createFilter(delegateByFilter: CharacterViewController?) -> UIViewController {
        let view = FilterViewController()
//        let viewParent = CharacterViewController()
        let userDefaultsManager = UserDefaultsManager()
        let presenter = FilterPresenter(view: view,  userDefaultsManager: userDefaultsManager  )
        view.presenter = presenter
        view.characterFilterDelegate = delegateByFilter
        return view
    }
    
}
