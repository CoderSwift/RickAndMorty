import UIKit

class DescriptionCharacterTableViewCell: UITableViewCell {
    var titleCell = CustomLabel(textAlignment: .left, color: Color.orangeColor, font: UIFont.boldFont(ofSize: 18))
    var descriptionCell = CustomLabel(textAlignment: .left, color: .white, font: UIFont.normalFont(ofSize: 18))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor     = .clear
        selectionStyle      = .none
        
        addSubviews(titleCell,descriptionCell)

        NSLayoutConstraint.activate([
            titleCell.leftAnchor.constraint(equalTo: leftAnchor, constant: .zero),
            titleCell.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            descriptionCell.leftAnchor.constraint(equalTo: titleCell.rightAnchor, constant: Constraints.marginTopBottom),
            descriptionCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            descriptionCell.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setData(title: String?, value: String?) {
        guard let title = title,
              let value = value else { return }
        self.titleCell.text = "\(title):"
        self.descriptionCell.text = value
    }
    
}
