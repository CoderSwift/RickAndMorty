//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by coder on 19.05.21.
//

import UIKit

class MainViewController: UIViewController {
    
    let loaderView =  LoaderView()
    let titleSection =  CustomLabel()
    
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureTextLabel()
        configureLoaderView()
        presenter.showGreeting()  
//        presenter.startAnimation(indicatorImage: loaderView.indicatorImage)
    }
    
    func configureTextLabel() {
        view.addSubview(titleSection)
        titleSection.set(props: .align(.center), .color(.blue))
        titleSection.text = "text"
        NSLayoutConstraint.activate([
            
            titleSection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleSection.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
    
    func configureLoaderView() {
        view.addSubview(loaderView)
        loaderView.pinToEdges(of: view)
    }

}


extension MainViewController: MainViewProtocol{
    func setGreeting(text: String) {
        self.titleSection.text = text
    }
    
    
}
