//
//  LoaderView.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit


class LoaderView: UIView {
    
    var headerImage = CustomImageView(radius: 0, frame: .zero, contentMode: .scaleAspectFill)
    var indicatorImage = CustomImageView(radius: 0, frame: .zero, contentMode: .scaleAspectFill)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor(hexCode: 0x25282E)
        translatesAutoresizingMaskIntoConstraints  = false
    }
    
    
    
    
}
