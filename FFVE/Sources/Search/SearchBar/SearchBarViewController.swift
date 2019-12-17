//
//  SearchBarViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 03/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    
    @IBOutlet weak var cityMemberTable: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var searchController: UISearchController!
    
    private var cityMemberDataSource = CityMemberTableDataSource()
    
    var viewModel: SearchBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
        bind(to: viewModel)
        bind(to: cityMemberDataSource)
        cityMemberTable.delegate = cityMemberDataSource
        cityMemberTable.dataSource = cityMemberDataSource
        
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func bind(to viewModel: SearchBarViewModel) {
        
        viewModel.descriptionLabelsHidden = { [weak self] state in
            self?.titleLabel.isHidden = state
            self?.descriptionLabel.isHidden = state
        }
        
        viewModel.cityMemberDescriptiontext = { [weak self] text in
            self?.descriptionLabel.text = text
        }
        
        viewModel.cityMemberTitleText = { [weak self] text in
            self?.titleLabel.text = text
        }
        
        viewModel.cities = { [weak self] cities in
            self?.cityMemberDataSource.setCities(cities: cities)
            self?.cityMemberTable.reloadData()
        }
        
        viewModel.memberList = { [weak self] members in
            self?.cityMemberDataSource.setMembers(members: members)
            self?.cityMemberTable.reloadData()
        }
        
        viewModel.tableViewHidden = { [weak self] state in
            self?.cityMemberTable.isHidden = state
        }
        
        viewModel.dismissButtonHidden = { [weak self] state in
            self?.dismissButton.isHidden = state
        }
    }
    
    private func bind(to dataSource: CityMemberTableDataSource) {
        dataSource.selectedCity = viewModel.didChooseCity
        dataSource.selectedMember = viewModel.didSelectMember
    }
    
    private func setNavBar() {
        
        navigationItem.title = "Recherche de membre"
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
        searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Ecrivez nom d'adhérent ou de ville"
        
        navigationItem.searchController = searchController
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    @objc private func buttonInfoTapped() {
        viewModel.didPressInfoLogo()
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        viewModel.dismissSearchBar()
    }
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        guard searchText.count > 2 else {viewModel.viewDidAppear(); return}
        viewModel.didTapThreeCharacters(enter: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.dismissSearchBar()
    }
}
