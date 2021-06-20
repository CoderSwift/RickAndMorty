//
//  LaunchPresenter.swift
//  RickAndMorty
//
//  Created by coder on 12.06.21.
//

import UIKit


protocol LaunchViewProtocol {
    
}

protocol LaunchPresenterProtocol {
    init (view:LaunchViewProtocol)
}

class LaunchPresenter:LaunchPresenterProtocol {
    
    var view:  LaunchViewProtocol?
    var repeatCount = 0
    var callback:  () -> () = {}
    
    required init(view: LaunchViewProtocol) {
        self.view = view
    }
    
    func animation(indicatorImage:UIImageView, callback:  @escaping ()->()) {
        if self.repeatCount < 1{
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { 
                    indicatorImage.transform = CGAffineTransform(rotationAngle: .pi)
                } completion: { (complated) in
                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                        indicatorImage.transform = CGAffineTransform(rotationAngle: 0)
                    } completion: { (complated) in
                        self.animation(indicatorImage: indicatorImage, callback: callback)
                    }
                }
            }
            repeatCount += 1
           
        } else {
            callback()
        }
        
    }
    
}


