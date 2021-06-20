//
//  HeaderFilterView.swift
//  RickAndMorty
//
//  Created by coder on 9.06.21.
//

import UIKit


class HeaderFilterView: UIView {
    
    var titleLabel = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 16))
    var resetButton = UIButton()
    var enabledButton:CGFloat = 1
    var disabledButton:CGFloat = 0.5
    var callback: ()->() = {}
   

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurate()
        
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
    
    func configurate(){
        addSubviews(titleLabel,resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.font = UIFont.boldFont(ofSize: 16)
        resetButton.setTitleColor(Color.redColor, for: .normal)
        resetButton.addTarget(self, action: #selector(resetFilter), for: .touchUpInside)
        NSLayoutConstraint.activate([
        
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constraints.margin),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            resetButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constraints.margin),
            resetButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
    

    @objc func resetFilter() {
        setEnabledButton(false)
    }
}
