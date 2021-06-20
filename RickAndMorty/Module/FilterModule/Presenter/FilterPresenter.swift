//
//  FilterPresenter.swift
//  RickAndMorty
//
//  Created by coder on 8.06.21.
//

import Foundation


protocol FilterViewProtocol {
    func reloadCollectionView()
}

protocol FilterPresenterProtocol {
    init(view: FilterViewProtocol,  userDefaultsManager: UserDefaultsManagerProtocol)
    var view: FilterViewProtocol {get set}
    func setFilterToUserDefaults()
    func setFilterSelected()
    var currentStatus: String {get set}
    var currentGender: String {get set}
    var filterStatus:[Status] {get set}
    var filterGender:[Gender] {get set}
    var stateCellStatus:[String : Int?] {get set}
    var stateCellGender:[String : Int?] {get set}
    func selectedOptionFiltered(indexPath: IndexPath)
}

class FilterPresenter: FilterPresenterProtocol {
        
    var view: FilterViewProtocol
    let userDefaultsManager: UserDefaultsManagerProtocol!
    var filter: FilterUserDefaults?
    
    var filterStatus:[Status] = [.alive,.dead,.unknown]
    var filterGender:[Gender] = [.female,.male,.genderless,.unknown]
    var currentStatus = ""
    var currentGender = ""
    var currentIndexFilter = ["Status": Int?.none, "Gender": Int?.none]
    var stateCellStatus:[String : Int?] = ["selectedStatus": nil, "resetStatus": nil]{
        didSet{
            view.reloadCollectionView()
           
        }
    }
    
    var stateCellGender:[String : Int?] = ["resetGender": nil, "selectedGender": nil ] {
        didSet{
            view.reloadCollectionView()
        }
    }
    
    
    required init(view:FilterViewProtocol,  userDefaultsManager: UserDefaultsManagerProtocol) {
        self.view = view
        self.userDefaultsManager = userDefaultsManager
    }
    
    
    func setFilterToUserDefaults() {
        self.filter = UserDefaultsManager.shared.getSettings()
        self.filter?.gender = self.currentGender
        self.filter?.status = self.currentStatus
    }
    
    func setFilterSelected() {
        self.filter = UserDefaultsManager.shared.getSettings()
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
    
    func updateStatusIndex(_ indexPath: IndexPath) {
        stateCellStatus["selectedStatus"] = indexPath.row
        stateCellStatus["resetStatus"] = indexPath.section
    }
    func updateGenderIndex(_ indexPath: IndexPath) {
        stateCellGender["selectedGender"] = indexPath.row
        stateCellGender["resetGender"] = indexPath.section
    }
//    func resetStatusIndex(_ index: Int) {
//        stateCellStatus["resetStatus"] = index
//    }
//    func resetGenderIndex(_ index: Int) {
//        stateCellGender["resetGender"] = index
//    }
    
    func selectedOptionFiltered(indexPath: IndexPath) {
        switch indexPath.section{
            case 0:
                updateStatusIndex(indexPath)
//                resetStatusIndex(indexPath.section)
                currentStatus = filterStatus[indexPath.row].rawValue
            default:
                updateGenderIndex(indexPath)
//                resetGenderIndex(indexPath.section)
               currentGender = filterGender[indexPath.row].rawValue
                print()
        }
    }
    
}


