//
//  ListViewController.swift
//  RickAndMorty
//
//  Created by coder on 29.05.21.
//

import UIKit

class CharacterViewController: UIViewController {

    var presenter: CharacterPresenter!
    var collectionView: UICollectionView!
    var searchTextField = SearchTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleViewController()
        configureSearchTextFild()
        configureCollectionView()
    }
    
    func configureStyleViewController (){
        self.navigationItem.title = "Characters"
        self.view.backgroundColor = Backgrounds.darkGray
    }
    
    func configureSearchTextFild() {
        view.addSubview(searchTextField)
    
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.margin),
            searchTextField.heightAnchor.constraint(equalToConstant: Constraints.heightSearchTextField)
        ])
    }
    
    func configureCollectionView () {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID)
        
        NSLayoutConstraint.activate([

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo:searchTextField.bottomAnchor, constant: .zero)

        ])
    }
}

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - (Constraints.margin*3))/2, height: Cell.characterCellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: Constraints.margin, left: Constraints.margin, bottom: Constraints.margin, right: Constraints.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.charactersData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseID, for: indexPath) as!  CharacterCollectionViewCell
        cell.setData(data: presenter.charactersData![indexPath.row])
        return cell
    }
}

extension CharacterViewController: CharacterViewProtocol {
    
}
