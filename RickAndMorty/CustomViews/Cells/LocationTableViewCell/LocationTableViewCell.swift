import UIKit

class LocationTableViewCell: UITableViewCell {
    var titleLabel = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 18))
    var descriptionLabel =  CustomLabel(textAlignment: .left, color: Color.lightGrayColor, font: UIFont.normalFont(ofSize: 14))
    var boxViewCell = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(dataModel: LocationsResult?){
        titleLabel.text = dataModel?.name
        descriptionLabel.text = dataModel?.type
    }
    
    private func configure() {
        backgroundColor                                         = .clear
        selectionStyle                                          = .none
        
        addSubviews(boxViewCell, titleLabel, descriptionLabel)
       
        boxViewCell.backgroundColor                             = Backgrounds.lightGray
        boxViewCell.translatesAutoresizingMaskIntoConstraints   = false
        boxViewCell.shadowDecorate(radius: 15,  byRoundingCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner],  shadowSize: 5, shadowOpacity: 0.3)
        
        NSLayoutConstraint.activate([
            boxViewCell.leadingAnchor.constraint(equalTo:leadingAnchor, constant: Constraints.margin),
            boxViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.margin),
            boxViewCell.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            boxViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.margin),
            
            titleLabel.leadingAnchor.constraint(equalTo: boxViewCell.leadingAnchor, constant: Constraints.paddingInnerCell),
            titleLabel.trailingAnchor.constraint(equalTo: boxViewCell.trailingAnchor, constant: -Constraints.paddingInnerCell),
            titleLabel.topAnchor.constraint(equalTo: boxViewCell.topAnchor, constant: Constraints.paddingInnerCell),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: boxViewCell.leadingAnchor, constant: Constraints.paddingInnerCell),
            descriptionLabel.trailingAnchor.constraint(equalTo: boxViewCell.trailingAnchor, constant: -Constraints.paddingInnerCell),
            descriptionLabel.bottomAnchor.constraint(equalTo: boxViewCell.bottomAnchor, constant: -Constraints.paddingInnerCell),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constraints.marginTopBottom)
        ])
    }
}

