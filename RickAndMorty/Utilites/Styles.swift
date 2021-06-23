import UIKit

enum PropLabel {
    case text(_: String)
    case color(_: UIColor)
    case font(_: UIFont)
    case align(_: NSTextAlignment)
    
    func install(to label: UILabel) {
            switch self {
            case .align(let align):
                label.textAlignment = align
            case .text(let string):
                label.text = string
            case .color(let color):
                label.textColor = color
            case .font(let font):
                label.font = font
            }
        }
}
