//
//  RadioButtonTableViewCell'.swift
//  RickAndMorty
//
//  Created by coder on 8.06.21.
//

import UIKit

protocol selectedFilterDelegate{
    func isSelectedAll(_ selected: Bool)
}

class FilterTableViewCell:UITableViewCell {
    
    var icon  = UIImageView()
    var label  = CustomLabel(textAlignment: .left, color: .white, font: UIFont.normalFont(ofSize: 16))
    var checked = UIImage(named: "icon-check-on")
    var unChecked = UIImage(named: "icon-check-off")
    static let reuseID = "RadioButtonTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func isSelected(_ selected: Bool) {
            setSelected(selected, animated: false)
            let image = selected ? checked : unChecked
            let color = selected ? Color.orangeColor : .white
            icon.image = image
            label.textColor = color
    }
    
    
    func configure(){
        contentView.addSubviews(icon,label)
        icon.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        selectionStyle = .none
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.margin),
            icon.heightAnchor.constraint(equalToConstant: Constraints.heightIconRadioButton),
            icon.widthAnchor.constraint(equalToConstant: Constraints.heightIconRadioButton),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: Constraints.marginTopBottom),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Constraints.margin),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
    
    func setTitleCell(title:String?){
        label.text = title
    }
}

extension FilterTableViewCell: selectedFilterDelegate{
    func isSelectedAll(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = unChecked
        icon.image = image
        label.textColor = .red
    }
}

