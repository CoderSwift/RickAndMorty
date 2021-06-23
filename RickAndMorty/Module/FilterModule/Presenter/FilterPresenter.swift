import UIKit

protocol FilterViewProtocol:AnyObject {
    func succes()
}

protocol FilterPresenterProtocol:AnyObject {
    init(view: FilterViewProtocol)
    var filterStatus:[Status] {get set}
    var filterGender:[Gender] {get set}
    var stateCellStatus:[String : Int?] {get set}
    var stateCellGender:[String : Int?] {get set}
    func setFilterToUserDefaults()
    func setFilterSelected()
    func saveFilter()
    func selectedOptionFiltered(indexPath: IndexPath)
    func setHeaderViewForTableView(section: Int) -> UIView
}

class FilterPresenter: FilterPresenterProtocol {
    private let cell = FilterTableViewCell()
    weak var view: FilterViewProtocol?
    var filter: FilterUserDefaults?
    var selectedFilterDelegate: SelectedFilterDelegate?
    var filterStatus:[Status] = [.alive,.dead,.unknown]
    var filterGender:[Gender] = [.female,.male,.genderless,.unknown]
    private var currentStatus = ""
    private var currentGender = ""
    private var currentIndexFilter = ["Status": Int?.none, "Gender": Int?.none]
    var stateCellStatus:[String : Int?] = ["selectedStatus": nil, "resetStatus": nil]{
        didSet{
            view?.succes()
        }
    }
    var stateCellGender:[String : Int?] = ["resetGender": nil, "selectedGender": nil ] {
        didSet{
            view?.succes()
        }
    }
    
    required init(view:FilterViewProtocol) {
        self.view = view
    }
    
    func setFilterToUserDefaults() {
        filter = UserDefaultsManager.shared.getFilter()
        filter?.gender = currentGender
        filter?.status = currentStatus
        filter = FilterUserDefaults(status: currentGender, gender: currentStatus)
    }
    
    func saveFilter() {
        UserDefaultsManager.shared.setFilter(filter!)
    }
    
    func setFilterSelected() {
        filter = UserDefaultsManager.shared.getFilter()
        currentGender = filter?.gender ?? ""
        currentStatus = filter?.status ?? ""
        for element in filterStatus where element.rawValue ==  filter?.status {
            currentIndexFilter["Status"] = element.ordinal()
        }
        for element in filterGender where element.rawValue ==  filter?.gender  {
            currentIndexFilter["Gender"] = element.ordinal()
        }
        stateCellStatus["selectedStatus"] = currentIndexFilter["Status"]
        stateCellGender["selectedGender"] = currentIndexFilter["Gender"]
    }
    
    private func updateStatusIndex(_ indexPath: IndexPath) {
        stateCellStatus["selectedStatus"] = indexPath.row
        stateCellStatus["resetStatus"] = indexPath.section
    }
    
    private func updateGenderIndex(_ indexPath: IndexPath) {
        stateCellGender["selectedGender"] = indexPath.row
        stateCellGender["resetGender"] = indexPath.section
    }
    
    func selectedOptionFiltered(indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            updateStatusIndex(indexPath)
            currentStatus = filterStatus[indexPath.row].rawValue
        default:
            updateGenderIndex(indexPath)
            currentGender = filterGender[indexPath.row].rawValue
        }
    }
    
    func setHeaderViewForTableView(section: Int) -> UIView {
        let headerView = HeaderFilterView(frame: .zero)
        selectedFilterDelegate = cell
        
        switch section {
        case 0:
            headerView.setTitle(title: "Status")
            currentStatus == "" ? headerView.setEnabledButton(false) : headerView.setEnabledButton(true)
            headerView.resetButton.addTarget(self, action: #selector(tapForSectionStatus), for: .touchUpInside)
        default:
            headerView.setTitle(title: "Gender")
            currentGender == "" ? headerView.setEnabledButton(false)  : headerView.setEnabledButton(true)
            headerView.resetButton.addTarget(self, action: #selector(tapForSectionGender), for: .touchUpInside)
        }
        return headerView
    }
    
    @objc func tapForSectionStatus(){
        selectedFilterDelegate?.isSelectedAll(false)
        view?.succes()
        stateCellStatus.removeAll()
        currentStatus = ""
    }
    
    @objc func tapForSectionGender(){
        selectedFilterDelegate?.isSelectedAll(false)
        view?.succes()
        stateCellGender.removeAll()
        currentGender = ""
    }
}


