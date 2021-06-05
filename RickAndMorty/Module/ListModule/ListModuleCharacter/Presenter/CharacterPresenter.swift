import Foundation

protocol CharacterViewProtocol {
    
}

protocol CharacterPresenterProtocol {
    init(view: CharacterViewProtocol, model: [CharactersData])
    var charactersData: [CharactersData]? {get set}

}

class CharacterPresenter: CharacterPresenterProtocol{
    var view: CharacterViewProtocol?
    var charactersData: [CharactersData]?

    required init(view: CharacterViewProtocol, model: [CharactersData] ) {
        self.view = view
        self.charactersData = model
    }
}
