import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    let themesImage = CustomImageView(radius: 15, frame: .zero, contentMode: .scaleAspectFill)
    let themesLabel = CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(navigationInfo: NavigationInfo) {
        guard let image = navigationInfo.image else {return}
        self.themesImage.image = UIImage(named: image)
        self.themesLabel.text = navigationInfo.title
    }
    
    func configure() {
        shadowDecorate(radius: 15, byRoundingCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner], shadowSize: 4, shadowOpacity: 0.2)
        backgroundColor         = .white
        
        addSubviews(themesImage,themesLabel)
        
        themesImage.alpha       = 0.2
        
        NSLayoutConstraint.activate([
            themesImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            themesImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            themesImage.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            themesImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),
            
            themesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.margin),
            themesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.margin),
            themesLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.margin),
            themesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.margin)
        ])
    }
}
