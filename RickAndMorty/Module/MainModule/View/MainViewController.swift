import UIKit

class MainViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let titleSection =  CustomLabel(textAlignment: .center, color: .black, font: UIFont.boldFont(ofSize: 28))
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureCollectionView()
    }
    
    private func setStyleViewController() {
        navigationItem.title = "Choose section"
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = Backgrounds.darkGray
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.backgroundColor                              = .clear
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: Cell.reuseMainID)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - (Constraints.margin*2), height: (self.collectionView.bounds.height - (Constraints.margin*4))/CGFloat(presenter.navigationInfo.count))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: Constraints.margin, left: Constraints.margin, bottom: Constraints.margin, right: Constraints.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.navigationInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseMainID, for: indexPath) as!  MainCollectionViewCell
        cell.setData(navigationInfo: presenter.navigationInfo[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let characterViewController = ModuleBuilder.createChartacter()
            self.navigationController?.pushViewController(characterViewController, animated: true)
            guard let titlePage = presenter.navigationInfo[indexPath.row].title else {return}
            characterViewController.navigationItem.title = titlePage
        case 1:
            let locationViewController = ModuleBuilder.createLocation()
            self.navigationController?.pushViewController(locationViewController, animated: true)
            guard let titlePage = presenter.navigationInfo[indexPath.row].title else {return}
            locationViewController.navigationItem.title = titlePage
        default:
            let episodeViewController = ModuleBuilder.createEpisode()
            self.navigationController?.pushViewController(episodeViewController, animated: true)
            guard let titlePage = presenter.navigationInfo[indexPath.row].title else {return}
            episodeViewController.navigationItem.title = titlePage
        }
    }
}

extension MainViewController: MainViewProtocol{
    
}
