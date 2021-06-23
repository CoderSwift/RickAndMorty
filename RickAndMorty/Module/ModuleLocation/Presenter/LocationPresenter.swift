//
//  LocationPresenter.swift
//  RickAndMorty
//
//  Created by coder on 18.06.21.
//

import UIKit

protocol LocationViewProtocol {
    func succes()
    func failure()
    func loadingPage()
}

protocol LocationPresenterProtocol {
    init(view: LocationViewProtocol, networkManager: NetworkManagerProtocol)
    var searchQuery: String {get set}
    var locationData: [LocationsResult] {get set}
    func loadMoreData(scrollView: UIScrollView, tableView: UITableView)
    func requestByName(textField: UITextField)
    func getLocation()
    func tableViewError(tableView: UITableView, view: UIView)
}

class LocationPresenter: LocationPresenterProtocol {
            
    var view:LocationViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var locationData = [LocationsResult]()
    var searchQuery = ""
    var countPage = 1
    var loadMore = true
    var loadingPage = false
    
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
        self.view?.loadingPage()
        if locationData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getLocation()
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
