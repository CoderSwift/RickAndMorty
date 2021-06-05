//
//  ImageView.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit

class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(radius:CGFloat, frame:CGRect) {
        self.init(frame: .zero)
        layer.cornerRadius = radius
    }
    
    private func configure() {
        clipsToBounds               = true
        contentMode                 = .scaleAspectFill
        isUserInteractionEnabled    = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
