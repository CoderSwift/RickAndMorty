import UIKit

class ThemesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ThemesCell"
    
    let themesImage = CustomImageView(radius: 15, frame: .zero, contentMode: .scaleAspectFill)
    let themesLabel = CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(navigationInfo: NavigationInfo) {
        guard let image = navigationInfo.image else {return}
        self.themesImage.image = UIImage(named: image)
        self.themesLabel.text = navigationInfo.title
    }
    
    func configureCell() {
        addSubviews(themesImage,themesLabel)
        themesImage.alpha = 0.2
        shadowDecorate(radius: 15, byRoundingCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner], shadowSize: 4, shadowOpacity: 0.2)
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
        
            themesImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
            themesImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero),
            themesImage.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
            themesImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero),
            
            themesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.margin),
            themesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.margin),
            themesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.margin),
            themesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.margin)
            
        ])
        
    }
}
