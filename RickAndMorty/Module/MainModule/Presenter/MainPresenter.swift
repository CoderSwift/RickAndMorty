//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit

protocol MainViewProtocol {
    
}

protocol MainPresenterProtocol {
    init (view:MainViewProtocol, model: [NavigationInfo])
    var navigationInfo: [NavigationInfo]? { get set }
}

class MainPresenter: MainPresenterProtocol {
    var view: MainViewProtocol?
    var navigationInfo: [NavigationInfo]?
    
    required init(view: MainViewProtocol, model: [NavigationInfo]) {
        self.view = view
        self.navigationInfo = model
    }
    
}
