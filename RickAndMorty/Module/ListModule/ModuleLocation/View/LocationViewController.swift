//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by coder on 18.06.21.
//

import UIKit


class LocationViewController: UIViewController {
    
    var presenter: LocationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension LocationViewController:LocationViewProtocol {
    
}
