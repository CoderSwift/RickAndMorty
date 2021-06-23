import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    let imageCell = CustomImageView(radius: 15, frame: .zero, contentMode: .scaleAspectFill)
    let labelView = UIView()
    let titleLabel = CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(dataModel: CharactersResult?){
        guard let image = dataModel?.image else {return}
        self.imageCell.url(image)
        self.titleLabel.text = dataModel?.name
    }
    
    private func configure() {
        shadowDecorate(radius: 15,  byRoundingCorners: [],  shadowSize: 5, shadowOpacity: 0.3)
        
        addSubviews(imageCell,labelView,titleLabel)
        
        imageCell.image                                         = Image.placeholderImage
        imageCell.translatesAutoresizingMaskIntoConstraints     = false
        
        labelView.backgroundColor                               = .white
        labelView.translatesAutoresizingMaskIntoConstraints     = false
        labelView.alpha                                         = 0.5
        labelView.shadowDecorate(radius: 15, byRoundingCorners: [.layerMaxXMaxYCorner,.layerMinXMaxYCorner], shadowSize: 0, shadowOpacity: 0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        
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
