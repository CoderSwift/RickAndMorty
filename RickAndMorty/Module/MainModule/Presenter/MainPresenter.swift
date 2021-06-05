//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit

protocol MainViewProtocol {
    func setGreeting(text:String)
}

protocol MainPresenterProtocol {
    init (view:MainViewProtocol)
    func showGreeting()
}

class MainPresenter: MainPresenterProtocol {
    
    
    var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func showGreeting() {
        let text = "Print new message"
        self.view?.setGreeting(text: text)
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
