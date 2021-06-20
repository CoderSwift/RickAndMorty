//
//  LocationCollectionCell.swift
//  RickAndMorty
//
//  Created by coder on 13.06.21.
//

import UIKit


class LocationCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "LocationCell"
    var titleLabel = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 18))
    var descriptionLabel =  CustomLabel(textAlignment: .left, color: Color.lightGrayColor, font: UIFont.normalFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(dataModel: LocationsData){
        self.titleLabel.text = "Location"
//        print(dataModel.result?.name)
        self.descriptionLabel.text = "Location description"
    }
    
    func configure(){
        
        self.addSubviews(titleLabel,descriptionLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Constraints.marginTopBottom)
            
        ])
        
    }
}
