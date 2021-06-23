import UIKit

class LocationViewController: UIViewController {
    
    var tableView: UITableView!
    var searchTextField = SearchTextField()
    var presenter: LocationPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureSearchTextField()
        configureCollectionView()
        dismissKey()
        tableView.setLoading()
        presenter?.getLocation()
    }
    
    func setStyleViewController() {
        view.backgroundColor = Backgrounds.darkGray
    }
    
    func configureSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        
        NSLayoutConstraint.activate([
        
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.margin),
            searchTextField.heightAnchor.constraint(equalToConstant: Constraints.heightSearchTextField)
            
        ])
    }
    
    func configureCollectionView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
      
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
        
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constraints.margin)
            
        
        ])
    }
    
}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseID, for: indexPath) as! LocationTableViewCell
        cell.setData(dataModel: presenter?.locationData[indexPath.row])
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.presenter.loadMoreData(scrollView: scrollView, tableView: tableView)
    }
  
}

extension LocationViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.presenter?.requestByName(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LocationViewController: LocationViewProtocol {
    func succes() {
        tableView.restore()
        tableView.reloadData()
    }
    
    func failure() {
        tableView.setError(superview: self.view)
    }
    
    func loadingPage() {
        tableView.restore()
        tableView.reloadData()
        tableView.setLoading()
    }
}
