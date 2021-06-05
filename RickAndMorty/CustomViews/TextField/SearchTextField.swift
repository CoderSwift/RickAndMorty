import UIKit

class SearchTextField: UITextField {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius          = 10
        self.backgroundColor        = Backgrounds.lightGray
        
        tintColor                   = .white
        textColor                   = .white
        adjustsFontSizeToFitWidth   = true
        font                        = UIFont.normalFont(ofSize: 16)
        autocorrectionType          = .no
        returnKeyType               = .go
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        rightViewMode = .always
        attributedPlaceholder     = NSAttributedString(string: "Enter name", attributes:[NSAttributedString.Key.foregroundColor: Color.lightGrayColor])
        
        let iconView = UIImageView(frame: CGRect(x: Constraints.heightSearchTextField/2 - (Constraints.heightIconSearchTextField/2), y: Constraints.heightSearchTextField/2-(Constraints.heightIconSearchTextField/2), width: 14, height: 14)) 
        iconView.image = UIImage(named: "icon-search")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Constraints.heightSearchTextField, height: Constraints.heightSearchTextField))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        
    }

}
