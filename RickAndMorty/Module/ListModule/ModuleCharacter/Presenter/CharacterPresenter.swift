import UIKit

protocol CharacterViewProtocol   {
    func succes()
    func failure()
    func setLoading()
}

protocol CharacterPresenterProtocol   {
    init(view: CharacterViewProtocol,  userDefaultsManager:UserDefaultsManagerProtocol,  networkManager: NetworkManagerProtocol)
    func getCharacter()
    var searchQuery: String {get set}
    var currentStatus: String {get set}
    var currentGender: String {get set}
    var characterData: [CharactersResult] {get set}
    func setPlacholderForCell(cell:CharacterCollectionViewCell)
    func loadMoreData(scrollView: UIScrollView, collectionView: UICollectionView)
    func requestDataByName(textField: UITextField)
    func requestDataByFilter()
    func setUserDefault()
    func collectionError(collectionView: UICollectionView, view: UIView)
    
}


class CharacterPresenter: CharacterPresenterProtocol {
    
    var view: CharacterViewProtocol
    let networkManager: NetworkManagerProtocol!
    let userDefaultsManager: UserDefaultsManagerProtocol!
    var characterData = [CharactersResult]()
    var filter: FilterUserDefaults?
    var countPage = 1
    var searchQuery = ""
    var currentStatus = ""
    var currentGender = ""
    var loadMore = true
    var loadingPage = false
    
    required init(view: CharacterViewProtocol,   userDefaultsManager:UserDefaultsManagerProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.userDefaultsManager = userDefaultsManager
        self.networkManager = networkManager
    }
    
    func setPlacholderForCell(cell: CharacterCollectionViewCell){
        cell.imageCell.image = Image.placeholderImage
    }
    
    func requestDataByName(textField: UITextField){
        guard let textString = textField.text else { return }
        searchQuery = textString
        countPage = 1
        characterData.removeAll()
        self.view.setLoading()
        if characterData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getCharacter()
    }
    
    
    func setUserDefault(){
        self.filter = UserDefaultsManager.shared.getSettings()
        self.currentStatus = self.filter!.status
        self.currentGender = self.filter!.gender
        
    }
    
    func requestDataByFilter() {
        setUserDefault()
        countPage = 1
        characterData.removeAll()
        self.view.setLoading()
        if characterData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getCharacter()
    }
    
    func collectionError(collectionView: UICollectionView, view: UIView) {
        collectionView.setError(superview: view)
    }
    
    func loadMoreData(scrollView: UIScrollView, collectionView: UICollectionView) {
        let position = scrollView.contentOffset.y
        let tableViewContentSizeHeight = collectionView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (tableViewContentSizeHeight - 100 - scrollViewHeight) {
            getCharacter()
        }
    }
    
    
    func getCharacter(){
        guard !loadingPage && loadMore else {
            return
        }
        loadingPage = true
        
        networkManager.getCharacter(page: countPage, name: searchQuery, status: self.currentStatus, gender:self.currentGender) { [weak self] result  in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    if comments?.results == nil{
                        self.view.failure()
                    } else {
                        guard let data = comments?.results else {return}
                        self.characterData.append(contentsOf: data)
                        self.loadingPage = false
                        if comments?.info?.pages == self.countPage {
                            self.loadMore = false
                        }
                        self.countPage += 1
                        self.view.succes()
                    }
                case .failure:
                    self.loadingPage = false
                    self.view.failure()
                }
            }
        }
    }
}


