import UIKit

class FilterViewController: UIViewController {
    private var tableView: UITableView!
    private var filterButton = CustomButton(title: "Apply filter")
    var presenter: FilterPresenterProtocol?
    var parentPresent: CharacterPresenterProtocol?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureButton()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.setFilterSelected()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        presenter?.saveFilter()
    }
    
    private func setStyleViewController() {
        navigationItem.title = "Filter"
        view.backgroundColor = Backgrounds.darkGray
    }
    
    private func configureButton() {
        view.addSubview(filterButton)
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.margin),
            filterButton.heightAnchor.constraint(equalToConstant: 44)

        ])
    }
    
    @objc func applyFilter() {
        presenter?.setFilterToUserDefaults()
        parentPresent?.requestDataByFilter()
        navigationController?.popViewController(animated: true)
    }
    
    private func configureTableView() {
        tableView                                           = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.backgroundColor                           = .clear
        tableView.delegate                                  = self
        tableView.dataSource                                = self
        tableView.separatorStyle                            = .none
        tableView.separatorInset.left                       = 0
        tableView.isScrollEnabled                           = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Cell.reuseFilterID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: filterButton.topAnchor, constant: -Constraints.margin)
        ])
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constraints.heightHeaderTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Status.allStatus.count
        default:
            return Gender.allGender.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constraints.heightTableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        presenter?.setHeaderViewForTableView(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentIndex = indexPath.row
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseFilterID, for: indexPath) as! FilterTableViewCell
            let selected = currentIndex == presenter?.stateCellStatus["selectedStatus"]
            cell.setTitleCell(title: presenter?.filterStatus[indexPath.row].rawValue)
            cell.isSelected(selected)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseFilterID, for: indexPath) as! FilterTableViewCell
            let selected = currentIndex == presenter?.stateCellGender["selectedGender"]
            cell.setTitleCell(title: presenter?.filterGender[indexPath.row].rawValue)
            cell.isSelected(selected)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedOptionFiltered(indexPath: indexPath)
    }
}

extension FilterViewController: FilterViewProtocol{
    func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

