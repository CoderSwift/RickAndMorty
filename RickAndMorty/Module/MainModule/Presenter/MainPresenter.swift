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
    
    func startAnimation(indicatorImage:UIImageView) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { [self] in
            indicatorImage.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { (complated) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                indicatorImage.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { (complated) in
                self.startAnimation(indicatorImage: indicatorImage)
            }
        }
    }
    
}
