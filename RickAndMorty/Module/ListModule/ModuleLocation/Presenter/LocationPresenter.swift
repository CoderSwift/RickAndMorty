//
//  LocationPresenter.swift
//  RickAndMorty
//
//  Created by coder on 18.06.21.
//

import UIKit

protocol LocationViewProtocol {
    
}

protocol LocationPresenterProtocol {
    init(view: LocationViewProtocol, networkManager: NetworkManagerProtocol)
}

class LocationPresenter: LocationPresenterProtocol {
    
    var view:LocationViewProtocol?
    var networkManager: NetworkManagerProtocol?
    
    required init(view: LocationViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    
    
    
}
