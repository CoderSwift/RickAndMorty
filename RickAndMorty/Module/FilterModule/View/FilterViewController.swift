//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by coder on 8.06.21.
//

import UIKit

protocol ReloadDelegate {
    func reloadTable()
}

protocol CharacterFilterDelegate {
    func tapApplyFilter()
}

class FilterViewController: UIViewController {
    
    
    var presenter: FilterPresenterProtocol?
    var delegate: selectedFilterDelegate?
    var delegateTable: ReloadDelegate?
    var filter: FilterUserDefaults?
    var characterFilterDelegate: CharacterFilterDelegate?
    var cell = FilterTableViewCell()
    var filterButton = CustomButton(title: "Apply filter")
    var tableView: UITableView!
    
    var currentIndexFilter = ["Status": Int?.none, "Gender": Int?.none]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleViewController()
        configureButton()
        configureTableView()
        self.filter = UserDefaultsManager.shared.getSettings()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.setFilterSelected()
    }
    
    func setStyleViewController (){
        self.navigationItem.title = "Filter"
        self.view.backgroundColor = Backgrounds.darkGray
    }
    
    func configureButton() {
        view.addSubview(filterButton)
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.margin),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraints.margin),
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.margin),
            filterButton.heightAnchor.constraint(equalToConstant: Constraints.heightButtonFilter)
            
        ])
        
    }
    
    @objc func applyFilter() {
        
        self.presenter?.setFilterToUserDefaults()
        characterFilterDelegate?.tapApplyFilter()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorInset.left = 0
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.reuseID)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: self.filterButton.topAnchor, constant: Constraints.margin)
            
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
        let headerView = HeaderFilterView(frame: .zero)
        delegateTable = self
        delegate = cell
        
        switch section {
        case 0:
            headerView.setTitle(title: "Status")
            presenter?.currentStatus == "" ? headerView.setEnabledButton(false) : headerView.setEnabledButton(true)
            headerView.resetButton.addTarget(self, action: #selector(firstSectionTapped), for: .touchUpInside)
        default:
            headerView.setTitle(title: "Gender")
            presenter?.currentGender == "" ? headerView.setEnabledButton(false)  : headerView.setEnabledButton(true)
            headerView.resetButton.addTarget(self, action: #selector(secondSectionTapped), for: .touchUpInside)
        }
        return headerView
    }
    
    @objc func firstSectionTapped(){
        delegate?.isSelectedAll(false)
        delegateTable?.reloadTable()
        presenter?.stateCellStatus.removeAll()
        presenter?.currentStatus = ""
        
    }
    
    @objc func secondSectionTapped(){
        delegate?.isSelectedAll(false)
        delegateTable?.reloadTable()
        presenter?.stateCellGender.removeAll()
        presenter?.currentGender = ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentIndex = indexPath.row
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseID, for: indexPath) as! FilterTableViewCell
            let selected = currentIndex == presenter?.stateCellStatus["selectedStatus"]
            cell.setTitleCell(title: presenter?.filterStatus[indexPath.row].rawValue)
            cell.isSelected(selected)
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseID, for: indexPath) as! FilterTableViewCell
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
    func reloadCollectionView() {
        tableView.reloadData()
    }
    
    
}

extension FilterViewController: ReloadDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

