import UIKit

class CustomImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(radius:CGFloat, frame:CGRect, contentMode: UIView.ContentMode ) {
        self.init(frame: .zero)
        layer.cornerRadius                          = radius
        self.contentMode                            = contentMode
    }
    
    private func configure() {
        clipsToBounds                               = true
        isUserInteractionEnabled                    = true
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
