import UIKit

class HeaderFilterView: UIView {
    var titleLabel = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 16))
    var resetButton = UIButton()
    var enabledButton:CGFloat = 1
    var disabledButton:CGFloat = 0.5
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title:String?){
        self.titleLabel.text = title
    }
    
    func setEnabledButton(_ enabled: Bool){
        resetButton.isEnabled = enabled
        let enabled = enabled ? enabledButton : disabledButton
        resetButton.alpha = enabled
    }
    
    private func configure() {
        addSubviews(titleLabel,resetButton)
       
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints   = false
        resetButton.titleLabel?.font                            = UIFont.boldFont(ofSize: 16)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(Color.redColor, for: .normal)
        resetButton.addTarget(self, action: #selector(resetFilter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constraints.margin),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            resetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constraints.margin),
            resetButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc func resetFilter() {
        setEnabledButton(false)
    }
}
