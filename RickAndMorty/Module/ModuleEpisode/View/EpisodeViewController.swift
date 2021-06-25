import UIKit

class EpisodeViewController: UIViewController {
    var tableView: UITableView!
    private var searchTextField = SearchTextField()
    var presenter: EpisodePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureSearchTextField()
        configureTableView()
        dismissKey()
        tableView.setLoading()
        presenter?.getEpisode()
    }
    
    private func setStyleViewController(){
        view.backgroundColor = Backgrounds.darkGray
    }
    
    private func configureSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.margin),
            searchTextField.heightAnchor.constraint(equalToConstant: Constraints.heightSearchTextField)
        ])
    }
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor                               = .clear
        tableView.translatesAutoresizingMaskIntoConstraints     = false
        tableView.dataSource                                    = self
        tableView.delegate                                      = self
        tableView.showsVerticalScrollIndicator                  = false
        tableView.separatorStyle                                = .none
        tableView.rowHeight                                     = UITableView.automaticDimension
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: Cell.reuseEpisodeID)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constraints.margin)
        ])
    }
}

extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.episodeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.reusableCell(tableView: tableView, indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.presenter.loadMoreData(scrollView: scrollView, tableView: tableView)
    }
}

extension EpisodeViewController:EpisodeViewProtcol {
    func succes() {
        tableView.resetError()
        tableView.reloadData()
    }
    
    func failure() {
        tableView.setError(superview: view)
    }
    
    func loadingPage() {
        tableView.resetError()
        tableView.reloadData()
        tableView.setLoading()
    }
}

extension EpisodeViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter?.requestByName(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

