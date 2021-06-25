import UIKit

protocol LocationViewProtocol:AnyObject {
    func succes()
    func failure()
    func loadingPage()
}

protocol LocationPresenterProtocol:AnyObject {
    init(view: LocationViewProtocol, networkManager: NetworkManagerProtocol)
    var locationData: [LocationsResult] {get set}
    func loadMoreData(scrollView: UIScrollView, tableView: UITableView)
    func requestByName(textField: UITextField)
    func getLocation()
    func tableViewError(tableView: UITableView, view: UIView)
    func reusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

class LocationPresenter: LocationPresenterProtocol {
    weak var view:LocationViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var locationData = [LocationsResult]()
    private var searchQuery = ""
    private var countPage = 1
    private var loadMore = true
    private var loadingPage = false
    
    required init(view: LocationViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func loadMoreData(scrollView: UIScrollView, tableView: UITableView) {
        let position = scrollView.contentOffset.y
        let tableViewContentSizeHeight = tableView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (tableViewContentSizeHeight - 100 - scrollViewHeight) {
            getLocation()
        }
    }
    
    func requestByName(textField: UITextField) {
        guard let textString = textField.text else {return}
        searchQuery = textString
        countPage = 1
        locationData.removeAll()
        view?.loadingPage()
        if locationData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getLocation()
    }
    func reusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseLocationID, for: indexPath) as! LocationTableViewCell
        cell.setData(dataModel: locationData[indexPath.row])
        return cell
    }
    
    func getLocation() {
        guard !loadingPage && loadMore else {
            return
        }
        loadingPage = true
    
        networkManager?.getLocation(page: countPage, name: searchQuery, completion: { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    if location?.results == nil{
                        self.view?.failure()
                    } else {
                        guard let data = location?.results else {return}
                        self.locationData.append(contentsOf: data)
                        self.loadingPage = false
                        if location?.info?.pages == self.countPage {
                            self.loadMore = false
                        }
                        self.countPage += 1
                        self.view?.succes()
                    }
                case .failure:
                    self.loadingPage = false
                    self.view?.failure()
                }
            }
            
        })
        
    }
    
    func tableViewError(tableView: UITableView, view: UIView) {
        tableView.setError(superview: view)
    }
    
}
