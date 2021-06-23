import UIKit

protocol DetailCharacterViewProtocol:AnyObject {
    func setCharacter(dataCharacter: CharactersResult?)
}

protocol DetailCharacterPresenterProtocol: AnyObject {
    var characterData: CharactersResult? {get set}
    var characterDataRow: [CharactersResultType] {get set}
    func setCharacter()
}

class DetailCharacterPresenter: DetailCharacterPresenterProtocol {
    weak var view: DetailCharacterViewProtocol?
    var characterData: CharactersResult?
    var characterDataRow: [CharactersResultType] = [
        .name,
        .gender,
        .status,
        .species
    ]
    
    init(view:DetailCharacterViewProtocol, model:CharactersResult) {
        self.view = view
        self.characterData = model
    }
    
    func setCharacter() {
        self.view?.setCharacter(dataCharacter: characterData)
    }
}
