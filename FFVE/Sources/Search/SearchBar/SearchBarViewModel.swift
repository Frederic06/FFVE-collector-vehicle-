//
//  SearchBarViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 03/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class SearchBarViewModel{
    
    // MARK: - Properties
    
    private weak var delegate: SearchDelegate?
    
    private var repository: SearchRepositoryType
    
    private var glGeocoderHelper = GLGeocoderHelper()
    
    private var members: [MemberItem] = []
    
    // MARK: - Init
    
    init(delegate: SearchDelegate, repository: SearchRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var cities: (([City]) -> Void)?
    
    var memberList: (([MemberItem]) -> Void)?
    
    var cityMemberTitleText: ((String) -> Void)?
    
    var cityMemberDescriptiontext: ((String) -> Void)?
    
    var descriptionLabelsHidden: ((Bool) -> Void)?
    
    var tableViewHidden: ((Bool) -> Void)?
    
    var dismissButtonHidden: ((Bool) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        getAllMembers()
        cityMemberTitleText?("Recherchez un membre ou une ville")
        cityMemberDescriptiontext?("Entrez un minimum de trois lettres")
        descriptionLabelsHidden?(false)
        tableViewHidden?(true)
        dismissButtonHidden?(false)
    }
    
    func didTapThreeCharacters(enter: String) {
        dismissButtonHidden?(true)
        
        descriptionLabelsHidden?(true)
        
        let filteredCities = filterCities(with: enter)
        self.cities?(filteredCities)
        
        let filteredMembers = filterMemnbers(with: enter)
        self.memberList?(filteredMembers)
        
        if filteredMembers == [] && filteredCities == [] {
            delegate?.alert(type: .noMember)
        } else {
            tableViewHidden?(false)
        }
    }
    
    func didChooseCity(enter: String) {
        let filter = FiltersItem(city: enter)
        delegate?.seeMembers(filters: filter)
    }
    
    func didSelectMember(member: MemberItem) {
        delegate?.seeMemberDetail(member: member)
    }
    
    // MARK: - Private methods
    
    private func getAllMembers() {
        repository.getMembers(completion: { members in
            switch members {
                
            case .success(value: let
                memberArray):
                self.glGeocoderHelper.addCoordinates(members: memberArray, completion: { membersLocated in
                    self.members = membersLocated
                })
                
            case .error:
                self.delegate?.alert(type: .networkError)
            }
        })
    }
    
    private func filterCities(with filter: String) -> [City] {
        
        let firstUpper = filter.firstCharacterUpperCase()
        
        let cities: [City] = self.members.map{ return City(cityName: $0.city, departmentNumber: $0.department_no) }.compactMap{ $0 }
        
        let citiesFiltered = cities.filter { $0.cityName.contains(firstUpper) }
        
        let uniquesFilteredCities = Array(Set(citiesFiltered))
        
        return (uniquesFilteredCities)
    }
    
    private func filterMemnbers(with filter: String) -> [MemberItem] {
        
        let memberFilter: [MemberItem] = self.members.filter { $0.name.contains(filter) }
        
        return (memberFilter)
    }
    
    func dismissSearchBar() {
        delegate?.dismissVC()
    }
    
    func didPressInfoLogo() {
        delegate?.didPressFFVELogo()
    }
}
