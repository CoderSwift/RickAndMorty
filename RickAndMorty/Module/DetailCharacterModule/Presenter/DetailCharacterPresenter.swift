import UIKit

protocol DetailCharacterViewProtocol:AnyObject {
    func setCharacter(dataCharacter: CharactersResult?)
}

protocol DetailCharacterPresenterProtocol: AnyObject {
    var characterData: CharactersResult? {get set}
    var characterDataRow: [CharactersResultType] {get set}
    func setCharacter()
    func reusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
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
    
    func reusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseDetailCharacterID, for: indexPath) as! DescriptionCharacterTableViewCell
        let infoType = characterDataRow[indexPath.row]
        switch infoType {
        case .name:
            cell.setData(title: infoType.rawValue, value: characterData?.name)
        case .status:
            cell.setData(title: infoType.rawValue, value: characterData?.status)
        case .species:
            cell.setData(title: infoType.rawValue, value: characterData?.species)
        case .gender:
            cell.setData(title: infoType.rawValue, value: characterData?.gender)
        }
        return cell
    }
}
