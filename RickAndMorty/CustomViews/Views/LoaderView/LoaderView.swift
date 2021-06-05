//
//  LoaderView.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit


class LoaderView: UIView {
    
    var headerImage = CustomImageView(radius: 0, frame: .zero)
    var indicatorImage = CustomImageView(radius: 0, frame: .zero)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
        setHeaderImage(image: Image.loaderHeaderImage!)
        setIndicatorImage(image: Image.indicatorImage!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor(hexCode: 0x25282E)
        translatesAutoresizingMaskIntoConstraints  = false
    }
    
    private func setHeaderImage(image: UIImage) {
        self.addSubview(headerImage)
        headerImage.image = image
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .zero),
            headerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.margin),
            headerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.margin),
            headerImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constraints.aspectRatioLoaderHeader)
        ])
    }
    
    private func setIndicatorImage(image: UIImage) {
        self.addSubview(indicatorImage)
        indicatorImage.image = image
        NSLayoutConstraint.activate([
            indicatorImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicatorImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constraints.aspectRatioIndicatorImage),
            indicatorImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constraints.aspectRatioIndicatorImage)
        ])
    }
    
    
}
