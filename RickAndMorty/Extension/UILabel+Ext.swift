//
//  Label+Wxt.swift
//  RickAndMorty
//
//  Created by coder on 20.05.21.
//

import UIKit

extension UILabel {
    func set(props: PropLabel...) {
        props.forEach { $0.install(to: self) }
    }
}
