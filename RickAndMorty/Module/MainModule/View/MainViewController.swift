//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by coder on 19.05.21.
//

import UIKit

class MainViewController: UIViewController {
    
    
    let titleSection =  CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 24))
    var collectionView: UICollectionView!
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureCollectionView()
    }
    
   
    
    func setStyleViewController(){
        self.navigationItem.title = "Choose section"
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.view.backgroundColor = Backgrounds.darkGray
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ThemesCollectionViewCell.self, forCellWithReuseIdentifier: ThemesCollectionViewCell.reuseID)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        ])
    }
    
}

extension MainViewController: MainViewProtocol{

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - (Constraints.margin*2), height: (self.collectionView.bounds.height - (Constraints.margin*4))/CGFloat(presenter.navigationInfo!.count))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: Constraints.margin, left: Constraints.margin, bottom: Constraints.margin, right: Constraints.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.navigationInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemesCollectionViewCell.reuseID, for: indexPath) as!  ThemesCollectionViewCell
        cell.setData(navigationInfo: (presenter.navigationInfo?[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            let characterViewController = ModuleBuilder.createChartacter()
            self.navigationController?.pushViewController(characterViewController, animated: true)
            guard let titlePage = presenter.navigationInfo?[indexPath.row].title else {return}
            characterViewController.navigationItem.title = titlePage

       
    }
    
}
