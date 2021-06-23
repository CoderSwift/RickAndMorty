import UIKit

extension UITableView {
    func setLoading(){
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .white
        self.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    
    func setError(superview: UIView) {
        let error = ErrorView(frame: CGRect(x: 0, y: 0, width: superview.frame.size.width, height: superview.frame.size.height))
        backgroundView = error
    }
    
    func resetError() {
        backgroundView = nil
    }
}
