import UIKit

protocol MainViewProtocol:AnyObject {
    
}

protocol MainPresenterProtocol:AnyObject {
    init (view:MainViewProtocol, model: [NavigationInfo])
    var navigationInfo: [NavigationInfo] { get }
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var navigationInfo: [NavigationInfo]
    
    required init(view: MainViewProtocol, model: [NavigationInfo]) {
        self.view = view
        self.navigationInfo = model
    }
}
