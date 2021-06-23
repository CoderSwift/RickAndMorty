import UIKit

protocol LaunchViewProtocol: AnyObject {
    
}

protocol LaunchPresenterProtocol: AnyObject {
    init (view:LaunchViewProtocol)
}

class LaunchPresenter:LaunchPresenterProtocol {
    weak var view:  LaunchViewProtocol?
    private var repeatCount = 0
    var callback:  () -> () = {}
    
    required init(view: LaunchViewProtocol) {
        self.view = view
    }
    
    func animation(indicatorImage:UIImageView, callback:  @escaping ()->()) {
        if self.repeatCount < 1{
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { 
                    indicatorImage.transform = CGAffineTransform(rotationAngle: .pi)
                } completion: { (complated) in
                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                        indicatorImage.transform = CGAffineTransform(rotationAngle: 0)
                    } completion: { (complated) in
                        self.animation(indicatorImage: indicatorImage, callback: callback)
                    }
                }
            }
            repeatCount += 1
        } else {
            callback()
        }
    }
    
}


