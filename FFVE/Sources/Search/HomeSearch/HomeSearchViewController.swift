//
//  ResearchViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class HomeSearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: HomeSearchViewModel!
    
    private var departmentDataSource = DepartmentPickerDataSource()
    
    private var searchController: UISearchController!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        bind(to: departmentDataSource)
        setNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidAppear()
        setButtonConstraints()
        self.definesPresentationContext = true
    }
    
    // MARK: - Private methods
    
    private func bind(to viewModel: HomeSearchViewModel) {
        
        viewModel.titleDescriptionText = { [weak self] text in
            self?.titleDescriptionLabel.text = text
        }
        
        viewModel.descriptionLabelText = { [weak self] text in
            self?.descriptionLabel.text = text
        }
        
        viewModel.titleDescriptionHidden = { [weak self] state in
            self?.titleDescriptionLabel.isHidden = state
        }
        
        viewModel.descriptionLabelHidden = { [weak self] state in
            self?.descriptionLabel.isHidden = state
        }
        
        
        viewModel.firstButtonHidden = { [weak self] state in
            self?.firstButton.isHidden = state
        }
        
        viewModel.firstButtonText = { [weak self] text in
            self?.firstButton.setTitle(text, for: .normal)
        }
        
        viewModel.firstLabelText = { [weak self] text in
            self?.firstLabel.text = text
        }
        
        viewModel.firstLabelHidden = { [weak self] state in
            if state == true {
                self?.firstLabel.alpha = 0
            } else {
                self?.firstLabel.alpha = 1
            }
        }
        
        viewModel.secondButtonHidden = { [weak self] state in
            if state == true {
                self?.secondButton.alpha = 0
            } else {
                self?.secondButton.alpha = 1
            }
        }
        
        viewModel.secondButtonText = { [weak self] text in
            self?.secondButton.setTitle(text, for: .normal)
        }
        
        viewModel.secondLabelText = { [weak self] text in
            self?.secondLabel.text = text
        }
        
        viewModel.secondLabelHidden = { [weak self] state in
            if state == true {
                self?.secondLabel.alpha = 0
            } else {
                self?.secondLabel.alpha = 1
            }
        }
        
        viewModel.thirdButtonHidden = { [weak self] state in
            if state == true {
                self?.thirdButton.alpha = 0
            } else {
                self?.thirdButton.alpha = 1
            }
        }
        
        viewModel.thirdButtonText = { [weak self] text in
            self?.thirdButton.setTitle(text, for: .normal)
        }
        
        viewModel.thirdLabelHidden = { [weak self] state in
            if state == true {
                self?.thirdLabel.alpha = 0
            } else {
                self?.thirdLabel.alpha = 1
            }
        }
        
        viewModel.thirdLabelText = { [weak self] text in
            self?.thirdLabel.text = text
        }
        
        viewModel.searchButtonText = { [weak self] text in
            self?.searchButton.setTitle(text, for: .normal)
        }
        
        viewModel.searchButtonHidden = { [weak self] state in
            self?.searchButton.isHidden = state
        }
        
        viewModel.pickerArray = { [weak self] departments in
            self?.departmentDataSource.updateDepartments(departments: departments)
        }
    }
    
    private func bind(to dataSource: DepartmentPickerDataSource) {
        dataSource.didSelectItem = viewModel.didSelect
    }
    
    private func setNavBar() {
        self.navigationItem.title = "Recherche de membre"
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        
        searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Ecrivez nom d'adhérent ou de ville"
        navigationItem.searchController = searchController
    }
    
    private func setButtonConstraints() {
        firstButton.contentHorizontalAlignment = .left
        thirdButton.contentHorizontalAlignment = .left
        secondButton.contentHorizontalAlignment = .left
        setRounded(buttons: [firstButton, secondButton, thirdButton, searchButton])
    }
    
    private func setRounded(buttons: [UIButton]) {
        for button in buttons {
            button.backgroundColor = #colorLiteral(red: 0.3115793765, green: 0.2650237381, blue: 0.7776248455, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
        }
    }
    
    @objc private func rightButtonTapped() {
        viewModel.didPressInfoLogo()
    }
    
    // MARK: - Actions
    
    @IBAction func firstButton(_ sender: UIButton) {
        viewModel.didPressMemberTypeFilter(datasource: departmentDataSource)
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        viewModel.didPressFilter(from: .secondButton, dataSource: departmentDataSource)
    }
    
    @IBAction func thirdButton(_ sender: UIButton) {
        viewModel.didPressFilter(from: .thirdButton, dataSource: departmentDataSource)
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        navigationItem.title = ""
        viewModel.didPressSearch()
    }
    
    @objc func buttonInfoTapped() {
        viewModel.didPressInfoLogo()
    }
}

extension HomeSearchViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.didPressSearchBar()
    }
}
