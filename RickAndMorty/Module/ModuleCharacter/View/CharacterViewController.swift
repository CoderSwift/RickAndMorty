import UIKit

class CharacterViewController: UIViewController {
    
    var collectionView: UICollectionView!
    private var searchTextField = SearchTextField()
    var presenter: CharacterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureSearchTextFild()
        configureCollectionView()
        setFilterButton()
        dismissKey()
        collectionView.setLoading()
        presenter.setUserDefault()
        presenter.getCharacter()
    }
    
    private func setStyleViewController (){
        view.backgroundColor = Backgrounds.darkGray
    }
    
    private func configureSearchTextFild() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
    
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.marginTopBottom),
            searchTextField.heightAnchor.constraint(equalToConstant: Constraints.heightSearchTextField)
        ])
    }
    
    private func setFilterButton() {
        let buttonFilter = UIButton(frame: CGRect.init(x: 0, y: 0, width: 14, height: 14))
        buttonFilter.setImage(Image.iconFilter, for: .normal)
        let menuBarItem = UIBarButtonItem(customView: buttonFilter)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
        buttonFilter.addTarget(self, action: #selector(filterTap), for: .touchUpInside)
    }
    
    @objc func filterTap(){
        let filterViewController = ModuleBuilder.createFilter(parentPresent: presenter)
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    private func configureCollectionView () {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor                              = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.showsVerticalScrollIndicator                 = false
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: Cell.reuseCharacterID)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero),
            collectionView.topAnchor.constraint(equalTo:searchTextField.bottomAnchor, constant: Constraints.margin)
        ])
    }
}

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - (Constraints.margin*3))/2, height: Constraints.characterCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constraints.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: .zero, left: Constraints.margin, bottom: .zero, right: Constraints.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.characterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseCharacterID, for: indexPath) as!  CharacterCollectionViewCell
        presenter.setPlacholderForCell(cell: cell)
        cell.setData(dataModel: presenter.characterData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataCharacter = presenter.characterData[indexPath.row]
        let detailCharacterViewController = ModuleBuilder.createDetailCharacter(dataCharacter: dataCharacter)
        navigationController?.pushViewController(detailCharacterViewController , animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.loadMoreData(scrollView: scrollView, collectionView: collectionView)
    }
}

extension CharacterViewController: CharacterViewProtocol {
    func loadingPage() {
        collectionView.resetError()
        collectionView.reloadData()
        collectionView.setLoading()
    }
    
    func succes() {
        collectionView.resetError()
        collectionView.reloadData()
    }
    
    func failure() {
        collectionView.setError(superview: self.view)
    }
}

extension CharacterViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.requestDataByName(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
