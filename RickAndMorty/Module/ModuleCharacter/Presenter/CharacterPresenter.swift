import UIKit

protocol CharacterViewProtocol: AnyObject {
    func succes()
    func failure()
    func loadingPage()
}

protocol CharacterPresenterProtocol: AnyObject {
    init(view: CharacterViewProtocol,   networkManager: NetworkManagerProtocol)
    var characterData: [CharactersResult] {get set}
    func setPlacholderForCell(cell:CharacterCollectionViewCell)
    func loadMoreData(scrollView: UIScrollView, collectionView: UICollectionView)
    func requestDataByName(textField: UITextField)
    func requestDataByFilter()
    func getCharacter()
    func setUserDefault()
    func collectionError(collectionView: UICollectionView, view: UIView)
    func reusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

class CharacterPresenter: CharacterPresenterProtocol {
    weak var view: CharacterViewProtocol?
    let networkManager: NetworkManagerProtocol!
    var characterData = [CharactersResult]()
    private var filter: FilterUserDefaults?
    private var countPage = 1
    private var searchQuery = ""
    private var currentStatus = ""
    private var currentGender = ""
    private var loadMore = true
    private var loadingPage = false
    
    required init(view: CharacterViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
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
        guard  let view = view else { return print(Errors.loadFonts)}
        view.loadingPage()
        if characterData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getCharacter()
    }
    
    func setUserDefault(){
        filter = UserDefaultsManager.shared.getFilter()
        currentStatus = self.filter!.status
        currentGender = self.filter!.gender
    }
    
    func requestDataByFilter() {
        setUserDefault()
        countPage = 1
        characterData.removeAll()
        view?.loadingPage()
        if characterData.isEmpty {
            self.loadingPage = false
            self.loadMore = true
        }
        getCharacter()
    }
    
    func collectionError(collectionView: UICollectionView, view: UIView) {
        collectionView.setError(superview: view)
    }
    
    func reusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseCharacterID, for: indexPath) as!  CharacterCollectionViewCell
        setPlacholderForCell(cell: cell)
        cell.setData(dataModel: characterData[indexPath.row])
        return cell
    }
    
    func loadMoreData(scrollView: UIScrollView, collectionView: UICollectionView) {
        let position = scrollView.contentOffset.y
        let collectionViewContentSizeHeight = collectionView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (collectionViewContentSizeHeight - 100 - scrollViewHeight) {
            getCharacter()
        }
    }
    
    func getCharacter(){
        guard !loadingPage && loadMore else {
            return
        }
        loadingPage = true
        
        networkManager.getCharacter(page: countPage, name: searchQuery, status:currentStatus, gender:currentGender) { [weak self] result  in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    if character?.results == nil{
                        self.view?.failure()
                    } else {
                        guard let data = character?.results else {return}
                        self.characterData.append(contentsOf: data)
                        self.loadingPage = false
                        if character?.info?.pages == self.countPage {
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
        }
    }
}


