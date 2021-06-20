import UIKit

class ErrorView: UIView {
    
    var stackPictureAndTitle: UIStackView!
    var pictureImageView = CustomImageView(radius: 0, frame: .zero, contentMode: .scaleAspectFit)
    var titleLabel = CustomLabel(textAlignment: .center, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 26))
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setStyleViewController()
        configureStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyleViewController(){
        backgroundColor = .clear
    }
    
    private func configureStack() {
       
        stackPictureAndTitle = UIStackView(arrangedSubviews: [pictureImageView, titleLabel])
        addSubview(stackPictureAndTitle)
        stackPictureAndTitle.translatesAutoresizingMaskIntoConstraints = false
        stackPictureAndTitle.axis = .vertical
        stackPictureAndTitle.distribution = .fillProportionally
        stackPictureAndTitle.alignment = .center
        
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.image  =  Image.errorImage
        
        titleLabel.text = """
        Look, Morty!
        There's nothing there!
        """
        
        NSLayoutConstraint.activate([
            stackPictureAndTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(Constraints.heightSearchTextField + Constraints.marginTopBottom)),
            stackPictureAndTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            pictureImageView.leadingAnchor.constraint(equalTo: self.stackPictureAndTitle.leadingAnchor, constant:  Constraints.margin),
            pictureImageView.trailingAnchor.constraint(equalTo: self.stackPictureAndTitle.trailingAnchor, constant: -Constraints.margin),
            pictureImageView.widthAnchor.constraint(equalToConstant: self.frame.width - (Constraints.margin*2)),
            pictureImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.stackPictureAndTitle.leadingAnchor, constant:  Constraints.margin),
            titleLabel.trailingAnchor.constraint(equalTo: self.stackPictureAndTitle.trailingAnchor, constant: -Constraints.margin),
            titleLabel.topAnchor.constraint(equalTo: self.pictureImageView.bottomAnchor, constant: Constraints.margin)
            
        ])
    }
    
}
