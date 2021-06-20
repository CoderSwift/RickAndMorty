//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by coder on 12.06.21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var headerImage = CustomImageView(radius: 0, frame: .zero, contentMode: .scaleAspectFit)
    var indicatorImage = CustomImageView(radius: 0, frame: .zero, contentMode: .scaleAspectFit)
    
    var presenter: LaunchPresenter!
    
    override func viewDidLoad() {
        setStyleViewController()
        setHeaderImage(image: Image.loaderHeaderImage!)
        setIndicatorImage(image: Image.indicatorImage!)
        presenter.animation(indicatorImage: indicatorImage) {
            let vcMain = ModuleBuilder.createMain()
            self.navigationController?.pushViewController(vcMain, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setStyleViewController(){
        self.view.backgroundColor = Backgrounds.darkGray
    }
    
    private func setHeaderImage(image: UIImage) {
        self.view.addSubview(headerImage)
        headerImage.image = image
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.margin),
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            headerImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3.5)
        ])
    }
    
    private func setIndicatorImage(image: UIImage) {
        self.view.addSubview(indicatorImage)
        indicatorImage.image = image
        NSLayoutConstraint.activate([
            indicatorImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constraints.aspectRatioIndicatorImage),
            indicatorImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constraints.aspectRatioIndicatorImage)
        ])
    }
    
}

extension LaunchViewController: LaunchViewProtocol{
    
}
