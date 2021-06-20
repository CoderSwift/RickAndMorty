//
//  DetailCharacterPresenter.swift
//  RickAndMorty
//
//  Created by coder on 6.06.21.
//

import UIKit

protocol DetailCharacterViewProtocol{
    func setCharacter(dataCharacter: CharactersResult?)
}

protocol DetailCharacterPresenterProtocol{
    var view: DetailCharacterViewProtocol{ get }
    var characterData: CharactersResult? {get set}
    var characterDataRow: [CharactersResultType] {get set}
    func setCharacter()
}

class DetailCharacterPresenter:DetailCharacterPresenterProtocol {

    var view: DetailCharacterViewProtocol
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
        self.view.setCharacter(dataCharacter: characterData)
    }
    
}
