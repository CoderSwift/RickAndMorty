import UIKit

protocol EpisodeViewProtcol:AnyObject {
    func succes()
    func failure()
    func loadingPage()
}

protocol EpisodePresenterProtcol:AnyObject {
    init(view: EpisodeViewProtcol, networkManager:NetworkManagerProtocol)
    var episodeData: [EpisodeResult] {get set}
    func loadMoreData(scrollView: UIScrollView, tableView: UITableView)
    func requestByName(textField: UITextField)
    func getEpisode()
    func tableViewError(tableView: UITableView, view: UIView)
}

class EpisodePresenter: EpisodePresenterProtcol {
    weak var view: EpisodeViewProtcol?
    private var networkManager: NetworkManagerProtocol?
    private var searchQuery = ""
    private var countPage = 1
    private var loadMore = true
    private var loadingPage = false
    var episodeData = [EpisodeResult]()
    
    required init(view: EpisodeViewProtcol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func loadMoreData(scrollView: UIScrollView, tableView: UITableView) {
        let positon = scrollView.contentOffset.y
        let tableViewContentSizeHeight = tableView.contentSize.height
        let scroolViewHeight = scrollView.frame.size.height
        
        if positon > (tableViewContentSizeHeight - 100 - scroolViewHeight) {
            getEpisode()
        }
    }
    
    func requestByName(textField: UITextField) {
        guard let textString = textField.text else {return}
        searchQuery = textString
        countPage = 1
        episodeData.removeAll()
        view?.loadingPage()
        if episodeData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getEpisode()
    }
    
    func getEpisode() {
        guard !loadingPage && loadMore else {
            return
        }
        loadingPage = true
        networkManager?.getEpisode(page: countPage, name: searchQuery, completion: { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let episode):
                    if episode?.results == nil{
                        self.view?.failure()
                    } else {
                        guard let data = episode?.results else { return }
                        self.episodeData.append(contentsOf: data)
                        self.loadingPage = false
                        if episode?.info?.pages == self.countPage {
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
