//
//  ModuleBuilder.swift
//  RickAndMorty
//
//  Created by coder on 28.05.21.
//

import UIKit


protocol Builder{
    static func createMain() -> UIViewController
    static func createChartacter() -> UIViewController
}

class ModuleBuilder:Builder {
    
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
        let model = [
            CharactersData(info: nil, result: CharactersResult(name: "Morty", status: nil, species: nil, gender: nil, location: nil, image: "image-navigation-1", episode: nil)),
            CharactersData(info: nil, result: CharactersResult(name: "Morty", status: nil, species: nil, gender: nil, location: nil, image: "image-navigation-1", episode: nil)),
            CharactersData(info: nil, result: CharactersResult(name: "Morty", status: nil, species: nil, gender: nil, location: nil, image: "image-navigation-1", episode: nil)),
            CharactersData(info: nil, result: CharactersResult(name: "Morty", status: nil, species: nil, gender: nil, location: nil, image: "image-navigation-1", episode: nil))
        ]
        let presenter = CharacterPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
}
