import UIKit

protocol MainViewProtocol:AnyObject {
    
}

protocol MainPresenterProtocol:AnyObject {
    init (view:MainViewProtocol, model: [NavigationInfo])
    var navigationInfo: [NavigationInfo] { get }
    func didSelectedCell(indexPath: IndexPath, navigationController: UINavigationController?)
    func reusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var navigationInfo: [NavigationInfo]
    
    required init(view: MainViewProtocol, model: [NavigationInfo]) {
        self.view = view
        self.navigationInfo = model
    }
    
    func reusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseMainID, for: indexPath) as!  MainCollectionViewCell
        cell.setData(navigationInfo: navigationInfo[indexPath.row])
        return cell
    }
    
    func didSelectedCell(indexPath: IndexPath, navigationController: UINavigationController?) {
        switch indexPath.row {
        case 0:
            let characterViewController = ModuleBuilder.createChartacter()
            navigationController?.pushViewController(characterViewController, animated: true)
            guard let titlePage = navigationInfo[indexPath.row].title else {return}
            characterViewController.navigationItem.title = titlePage
        case 1:
            let locationViewController = ModuleBuilder.createLocation()
            navigationController?.pushViewController(locationViewController, animated: true)
            guard let titlePage = navigationInfo[indexPath.row].title else {return}
            locationViewController.navigationItem.title = titlePage
        default:
            let episodeViewController = ModuleBuilder.createEpisode()
            navigationController?.pushViewController(episodeViewController, animated: true)
            guard let titlePage = navigationInfo[indexPath.row].title else {return}
            episodeViewController.navigationItem.title = titlePage
        }
    }
}
