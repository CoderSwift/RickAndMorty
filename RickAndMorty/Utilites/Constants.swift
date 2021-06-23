import UIKit

enum Image {
    static let loaderHeaderImage                    = UIImage(named: "image-loaderImage")
    static let indicatorImage                       = UIImage(named: "image-indicator")
    static let errorImage                           = UIImage(named: "image-error")
    static let placeholderImage                     = UIImage(named: "image-placeholder")
    static let iconFilter                           = UIImage(named: "icon-filter")
}

enum Constraints {
    static let margin:CGFloat                       = 24
    static let marginTopBottom:CGFloat              = 12
    static let paddingInnerCell:CGFloat             = 15
    static let heightLabelName:CGFloat              = 45
    static let aspectRatioLoaderHeader:CGFloat      = 9 / 25
    static let aspectRatioIndicatorImage:CGFloat    = 1 / 1.5
    static let heightSearchTextField:CGFloat        = 45
    static let heightIconSearchTextField:CGFloat    = 14
    static let heightIconRadioButton:CGFloat        = 15
    static let heightHeaderTableViewCell:CGFloat    = 50
    static let heightTableViewCell:CGFloat          = 30
    static let heightButtonFilter:CGFloat           = 105
    static let characterCellHeight:CGFloat          = 180
}

enum Backgrounds {
    static let darkGray                             = UIColor(hexCode: 0x25282E)
    static let lightGray                            = UIColor(hexCode: 0x505358)
    static let cellColor                            = UIColor(hexCode: 0xB0CC69)
}

enum Color {
    static let orangeColor                          = UIColor(hexCode: 0xC0D36C)
    static let lightGrayColor                       = UIColor(hexCode: 0x909091)
    static let redColor                             = UIColor(hexCode: 0xDA4C5F)
}

enum Cell {
    static let reuseEpisodeID                       = "EpisodeCell"
    static let reuseLocationID                      = "LocationCell"
    static let reuseCharacterID                     = "CharacterCell"
    static let reuseDetailCharacterID               = "DescriptionCharacterCell"
    static let reuseFilterID                        = "FilterCell"
    static let reuseMainID                          = "MainCell"
}


