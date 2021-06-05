//
//  Constants.swift
//  RickAndMorty
//
//  Created by coder on 19.05.21.
//

import UIKit

enum Image {
    static let loaderHeaderImage                        = UIImage(named: "image-loaderImage")
    static let indicatorImage                           = UIImage(named: "image-indicator")
}

enum Constraints {
    static let margin:CGFloat                           = 24
    static let heightLabelName:CGFloat                  = 45
    static let aspectRatioLoaderHeader:CGFloat          = 9 / 25
    static let aspectRatioIndicatorImage:CGFloat        = 1 / 1.5
    static let heightSearchTextField:CGFloat            = 45
    static let heightIconSearchTextField:CGFloat        = 14
}

enum Backgrounds {
    static let darkGray                                 = UIColor(hexCode: 0x25282E)
    static let lightGray                                = UIColor(hexCode: 0x505358)
}

enum Color {
    static let orangeColor                              = UIColor(hexCode: 0xC0D36C)
    static let lightGrayColor                           = UIColor(hexCode: 0x909091)
}

enum Cell {
    static let characterCellHeight:CGFloat              = 180
}
