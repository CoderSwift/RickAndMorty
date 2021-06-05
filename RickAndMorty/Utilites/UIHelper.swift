//
//  UIHelper.swift
//  RickAndMorty
//
//  Created by coder on 28.05.21.
//

import UIKit

enum UIHelper {
    
    static func createFlowLayout(in view: UIView, columnCell: CGFloat, cellHeight: CGFloat) -> UICollectionViewFlowLayout {
        let width                           = view.frame.width
        let padding: CGFloat                = Constraints.margin
        let minimumLineSpacing: CGFloat     = 20
        let availableWidth                  = width - (padding * (columnCell+1))
        let itemWidth                       = availableWidth / columnCell
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: cellHeight  )
        flowLayout.scrollDirection          = .vertical
        flowLayout.minimumInteritemSpacing  = minimumLineSpacing
        flowLayout.minimumLineSpacing       = padding
        return flowLayout
    }
}
