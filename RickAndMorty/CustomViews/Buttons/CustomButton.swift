import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String?) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints   = false
        titleLabel?.font                            = UIFont.boldFont(ofSize: 18)
        backgroundColor                             = .clear
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 1
        layer.borderColor                           = Color.orangeColor.cgColor
        setTitleColor(Color.orangeColor, for: .normal)
    }
}
