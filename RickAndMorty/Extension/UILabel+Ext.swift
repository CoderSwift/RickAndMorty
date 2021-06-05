import UIKit

extension UILabel {
    func set(props: PropLabel...) {
        props.forEach { $0.install(to: self) }
    }
}
