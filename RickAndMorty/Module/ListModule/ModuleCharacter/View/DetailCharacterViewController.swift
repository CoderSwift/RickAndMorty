//
//  DetailCharacterViewController.swift
//  RickAndMorty
//
//  Created by coder on 6.06.21.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    
    var presenter: DetailCharacterPresenterProtocol!
    var titleViewController: String?
    var characterData: CharactersResult?
    var detailImageBox = UIView()
    var detailImage = CustomImageView(frame: .zero)
    var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setStyleViewController()
        configureImage()
        configureTableView()
        presenter.setCharacter()
    
    }
    
    func setStyleViewController (){
        self.navigationItem.title = presenter.characterData?.name
        self.view.backgroundColor = Backgrounds.darkGray
    }
    
    func configureImage(){
        view.addSubview(detailImageBox)
        detailImageBox.addSubview(detailImage)
        detailImageBox.translatesAutoresizingMaskIntoConstraints = false
        detailImage.image = Image.placeholderImage
        detailImageBox.shadowDecorate(radius: 15, byRoundingCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], shadowSize: 4, shadowOpacity: 0.2)
        NSLayoutConstraint.activate([
            
            detailImageBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.marginTopBottom),
            detailImageBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            detailImageBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            detailImageBox.heightAnchor.constraint(equalTo: detailImageBox.widthAnchor, multiplier: 2/2),
            
            detailImage.topAnchor.constraint(equalTo: detailImageBox.topAnchor, constant: .zero),
            detailImage.leadingAnchor.constraint(equalTo: detailImageBox.leadingAnchor, constant: .zero),
            detailImage.trailingAnchor.constraint(equalTo: detailImageBox.trailingAnchor, constant: .zero),
            detailImage.bottomAnchor.constraint(equalTo: detailImageBox.bottomAnchor,  constant: .zero)
            
            
        ])
    }
    
    func  configureTableView(){
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorInset.left = 0
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: detailImageBox.bottomAnchor, constant: Constraints.marginTopBottom),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constraints.margin)
            
        ])
    }
    
}

extension DetailCharacterViewController: DetailCharacterViewProtocol {
    
    func setCharacter(dataCharacter: CharactersResult?) {
        guard let image = dataCharacter?.image else {return}
        self.detailImage.url(image)
    }
    
    
}

extension DetailCharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characterDataRow.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseID, for: indexPath) as! DescriptionTableViewCell
        let infoType = presenter.characterDataRow[indexPath.row]
        switch infoType {
        case .name:
            cell.setData(title: infoType.rawValue, value: presenter.characterData?.name)
        case .status:
            cell.setData(title: infoType.rawValue, value: presenter.characterData?.status)
        case .species:
            cell.setData(title: infoType.rawValue, value: presenter.characterData?.species)
        case .gender:
            cell.setData(title: infoType.rawValue, value: presenter.characterData?.gender)
        }
        return cell
    }
    
}
