//
//  ListViewController.swift
//  RickAndMorty
//
//  Created by coder on 29.05.21.
//

import UIKit

class ListViewController: UIViewController {

    var presenter: ListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(presenter.model)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListViewController: ListViewProtocol {
    
}
