import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
    
    func shadowDecorate(radius: CGFloat, byRoundingCorners: CACornerMask, shadowSize: CGFloat, shadowOpacity: Float) {
        layer.shadowColor       = UIColor.black.cgColor
        layer.shadowOffset      = CGSize(width: 0, height: 1.0)
        layer.shadowRadius      = shadowSize
        layer.shadowOpacity     = shadowOpacity
        layer.masksToBounds     = true
        layer.shadowPath        = UIBezierPath(roundedRect: bounds,  cornerRadius: radius).cgPath
        layer.cornerRadius      = radius
        layer.maskedCorners     = byRoundingCorners
    }
}
