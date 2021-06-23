import UIKit

extension UIFont {
    static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, Errors.loadFonts.rawValue)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func semiBoldFont(ofSize size: CGFloat) -> UIFont{
        return customFont(name: "Montserrat SemiBold", size: size)
    }
    
    static func boldFont(ofSize size: CGFloat) -> UIFont{
        return customFont(name: "Montserrat Bold", size: size)
    }
    
    static func normalFont(ofSize size: CGFloat) -> UIFont{
        return customFont(name: "Montserrat Regular", size: size)
    }
}
