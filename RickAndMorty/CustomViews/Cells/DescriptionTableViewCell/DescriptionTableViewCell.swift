//
//  DescriptionTableViewCell.swift
//  RickAndMorty
//
//  Created by coder on 6.06.21.
//

import UIKit


class DescriptionTableViewCell: UITableViewCell {
    
    static let reuseID = "DescriptionTableViewCell"
    
    var titleCell = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 18))
    var descriptionCell = CustomLabel(textAlignment: .left, color: .white, font: UIFont.normalFont(ofSize: 18))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure() {
        addSubviews(titleCell,descriptionCell)
        backgroundColor = .clear
        self.selectionStyle = .none
        NSLayoutConstraint.activate([
            
            titleCell.leftAnchor.constraint(equalTo: self.leftAnchor, constant: .zero),
            titleCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            descriptionCell.leftAnchor.constraint(equalTo: titleCell.rightAnchor, constant: Constraints.marginTopBottom),
            descriptionCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            descriptionCell.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
        
    }
    
    func setData(title: String?, value: String?) {
        guard let title = title,
              let value = value else { return }
        self.titleCell.text = "\(title):"
        self.descriptionCell.text = value
    }
    
}
