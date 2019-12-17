//
//  HomeSearchViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol SearchDelegate: class{
    func seeMembers(filters: FiltersItem)
    func memberChoiceAlert(closure: @escaping(MemberType?) -> Void)
    func clubChoiceAlert(closure: @escaping(MemberType?) -> Void)
    func alert(for filter: Filter, dataSource: DepartmentPickerDataSource, didPressOk: @escaping(Bool?) -> Void)
    func didTapOnSearchBar()
    func seeMemberDetail(member: MemberItem)
    func alert(type: AlertType)
    func dismissVC()
    func didPressFFVELogo()
    func didShare(objects: [AnyObject])
}

final class HomeSearchViewModel {
    
    // MARK: - Properties
    
    enum Button {
        case firstButton, secondButton, thirdButton
    }
    
    private weak var delegate: SearchDelegate?
    
    private var glGeocoderHelper = GLGeocoderHelper()
    
    private var memberTypeChoice: MemberType? { didSet {
        self.firstLabelText?("\(self.memberTypeChoice?.rawValue ?? "")")
        self.firstLabelHidden?(false)
        switch memberTypeChoice {
        case .auto( _):
            currentFilter = .brand
            secondButtonText?("     2 -> Choisissez une marque")
        case .professional( _):
            currentFilter = .speciality
            secondButtonText?("     2 -> Choisissez une spécialité")
        default:
            currentFilter = .department
            secondButtonText?("     2 -> Choisissez un département")
        }
        secondButtonHidden?(false)
        titleDescriptionHidden?(true)
        descriptionLabelHidden?(true)
        }
    }
    
    private var currentFilter: Filter? { didSet {
        setPickerData()
        }
    }
    
    private var provisoryItem: String?
    
    private var departmentChoice: String?
    
    private var specialityChoice: Speciality?
    
    private var previousFilter: Filter?
    
    private var members: [MemberItem]? = nil
    
    // MARK: - Init
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var titleDescriptionText: ((String) -> Void)?
    
    var titleDescriptionHidden: ((Bool) -> Void)?
    
    var descriptionLabelText: ((String) -> Void)?
    
    var descriptionLabelHidden: ((Bool) -> Void)?
    
    
    var firstButtonText: ((String) -> Void)?
    
    var firstButtonHidden: ((Bool) -> Void)?
    
    var firstLabelText: ((String) -> Void)?
    
    var firstLabelHidden: ((Bool) -> Void)?
    
    
    var secondButtonText: ((String) -> Void)?
    
    var secondButtonHidden: ((Bool) -> Void)?
    
    var secondLabelText: ((String) -> Void)?
    
    var secondLabelHidden: ((Bool) -> Void)?
    
    
    var thirdButtonText: ((String) -> Void)?
    
    var thirdButtonHidden: ((Bool) -> Void)?
    
    var thirdLabelText: ((String) -> Void)?
    
    var thirdLabelHidden: ((Bool) -> Void)?
    
    
    var searchButtonText: ((String) -> Void)?
    
    var searchButtonHidden: ((Bool) -> Void)?
    
    
    var pickerArray: (([String]) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        titleDescriptionText?("Instructions pour la recherche")
        descriptionLabelText?("""
            Deux possibilités:

        - Tappez un nom de ville ou de membre dans la barre de recherche supérieure

        - Suivez le chemin de recherche classique via les boutons de la page principale
        """)
        titleDescriptionHidden?(false)
        descriptionLabelHidden?(false)
        firstButtonText?("     1 -> Spécifiez le type d'adhérent")
        thirdButtonText?("     3 -> Choisissez un département")
        searchButtonText?("Lancez la recherche !!")
        firstButtonHidden?(false)
        secondButtonHidden?(true)
        thirdButtonHidden?(true)
        searchButtonHidden?(true)
        firstLabelHidden?(true)
        secondLabelHidden?(true)
        thirdLabelHidden?(true)
        previousFilter = nil
    }
    
    func didPressMemberTypeFilter(datasource: DepartmentPickerDataSource) {
        viewDidAppear()
        delegate?.memberChoiceAlert(closure: { (type) in
            switch type {
            case .club:
                self.delegate?.clubChoiceAlert(closure: { (clubType) in
                    switch clubType {
                    case nil:
                        return
                    default:
                        self.memberTypeChoice = clubType
                    }
                })
            case nil:
                return
            default:
                self.memberTypeChoice = type
            }
        })
    }
    
    func didPressFilter(from button: Button, dataSource: DepartmentPickerDataSource) {
        if button == .secondButton && previousFilter != nil {
            currentFilter = previousFilter
        }
        guard let filter = currentFilter else {return}
        presentFilterAlert(from: button, for: filter, dataSource: dataSource)
    }
    
    func didPressSearch() {
        let filters = FiltersItem(type: self.memberTypeChoice, department: self.departmentChoice)
        delegate?.seeMembers(filters: filters)
    }
    
    func didSelect(item: String) {
        self.provisoryItem = item
    }
    
    func didPressInfoLogo() {
        delegate?.didPressFFVELogo()
    }
    
    func didPressSearchBar() {
        delegate?.didTapOnSearchBar()
    }
    
    // MARK: - Private methods
    
    private func keepChoice(from filter: Filter, with choice: String){
        if filter == .department{
            guard choice != "Tous" && choice != "" else { departmentChoice = nil; return }
            
            switch String(choice.prefix(2)) {
            case "97":
                departmentChoice = String(choice.prefix(3))
            case "0":
                departmentChoice = String(choice.last!)
            default:
                departmentChoice = String(choice.prefix(2))
            }
        }
        
        if filter == .brand {
            if let enumChoice = Brand(rawValue: choice){
                self.memberTypeChoice = .auto(enumChoice)
            } else {
                self.memberTypeChoice = .auto(nil)
            }
            self.currentFilter = .department
            self.previousFilter = .brand
        }
        
        if filter == .speciality {
            if let specialityChoice = Speciality(rawValue: choice) {
                self.memberTypeChoice = .professional(specialityChoice)
            } else {
                self.memberTypeChoice = .professional(nil)
            }
            self.currentFilter = .department
            self.previousFilter = .speciality
        }
    }
    
    private func updateUI(for filter: Filter, with item: String, with button: Button) {
        
        switch filter {
        case .department:
            if Department(rawValue: item) != nil {
                if button == .secondButton {
                    self.secondLabelText?("Département \(item)")
                } else {
                    self.thirdLabelText?("Département \(item)")
                    self.thirdLabelHidden?(false)
                }
            } else {
                if button == .secondButton {
                    self.secondLabelText?("Tous les départements")
                } else {
                    self.thirdLabelText?("Tous les départements")
                    self.thirdLabelHidden?(false)
                }
            }
            self.searchButtonHidden?(false)
            
        case .brand:
            if (Brand(rawValue: item) != nil) {
                self.secondLabelText?("Marque : \(item)")
            } else {
                self.secondLabelText?("Toutes les marques")
            }
            self.thirdButtonHidden?(false)
            
        case .speciality:
            if Speciality(rawValue: item) != nil {
                self.secondLabelText?("Spécialité \(item)")
            } else {
                self.secondLabelText?("Toutes spécialités")
            }
            self.thirdButtonHidden?(false)
        }
    }
    
    private func setPickerData() {
        var array: [String]
        switch currentFilter {
        case .speciality:
            array = Speciality.allCases.map { $0.rawValue }
        case .brand:
            array = Brand.allCases.map { $0.rawValue }
        default:
            array = Department.allCases.map { $0.rawValue }
        }
        pickerArray?(array)
    }
    
    private func presentFilterAlert(from button: Button, for filter: Filter, dataSource: DepartmentPickerDataSource) {
        
        delegate?.alert(for: filter, dataSource: dataSource, didPressOk: { (response) in
            if response == true {
                let item = self.provisoryItem ?? ""
                self.updateUI(for: filter, with: item, with: button)
                self.keepChoice(from: filter, with: item)
                self.secondLabelHidden?(false)
            }
            self.provisoryItem = nil
        })
    }
}
