import UIKit

class CustomLabel: UILabel {
    override init(frame:CGRect){
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, color: UIColor, font:UIFont) {
        self.init(frame: .zero)
        self.textAlignment                          = textAlignment
        self.font                                   = font
        self.textColor                              = color
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth                   = true
        numberOfLines                               = 0
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
