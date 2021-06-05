//
//  Styles.swift
//  RickAndMorty
//
//  Created by coder on 19.05.21.
//

import UIKit


class Style {
    enum TitleChooseLabel {
        case fontSize(_: UIFont)
        func instal(to label: UILabel) {
            switch self {
            case .fontSize(let font):
                label.font = font
            }
        }
    }
}
