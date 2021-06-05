//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by coder on 2.06.21.
//

import UIKit

class CharacterCollectionViewCell:UICollectionViewCell {
    
    static let reuseID = "CharacterCell"
    
    let imageCell = CustomImageView(radius: 15, frame: .zero)
    let labelView = UIView()
    let titleLabel = CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setData(data: CharactersData){
        guard let image = data.result?.image else {return}
        self.imageCell.image = UIImage(named: image)
        self.titleLabel.text = data.result?.name
    }
    
    func configureCell() {
        addSubviews(imageCell,labelView,titleLabel)
        labelView.backgroundColor = .white
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        labelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelView.alpha = 0.5
        labelView.shadowDecorate(radius: 15, byRoundingCorners: [.layerMaxXMaxYCorner,.layerMinXMaxYCorner], shadowSize: 0, shadowOpacity: 0)
        shadowDecorate(radius: 15,  byRoundingCorners: [],  shadowSize: 5, shadowOpacity: 0.3)
        NSLayoutConstraint.activate([
        
            imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            imageCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            imageCell.topAnchor.constraint(equalTo: self.topAnchor,constant: .zero),
            imageCell.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: .zero),
            
            labelView.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: .zero),
            labelView.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: .zero),
            labelView.bottomAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: .zero),
            labelView.heightAnchor.constraint(equalToConstant: Constraints.heightLabelName),
            
            titleLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor)
        
        ])
        
    }
    
}
