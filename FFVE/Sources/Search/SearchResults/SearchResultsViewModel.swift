//
//  ClubResearchViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 02/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class SearchResultsViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: SearchDelegate?
    
    private var repository: SearchRepositoryType
    
    private var glGeocoderHelper = GLGeocoderHelper()
    
    private var filters: FiltersItem
    
    private var members: [MemberItem] = [] {
        didSet {
            memberArray?(members)
            activityIndicatorIsHidden?(true)
            tableHidden?(false)
        }
    }
    
    // MARK: - Init
    
    init(delegate: SearchDelegate, repository: SearchRepositoryType, filters: FiltersItem) {
        self.delegate = delegate
        self.repository = repository
        self.filters = filters
    }
    
    // MARK: - Outputs
    
    var switchTitle: ((String) -> Void)?
    
    var memberArray: (([MemberItem]) -> Void)?
    
    var zoomType: ((ZoomType) -> Void)?
    
    var activityIndicatorIsHidden: ((Bool) -> Void)?
    
    var tableHidden : ((Bool) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        switchTitle?("Liste / Carte")
        activityIndicatorIsHidden?(false)
        tableHidden?(true)
        repository.getMembers(completion: { members in
            switch members {
                
            case .success(value: let
                members):
                if let membersFiltered = self.filter(from: members, with: self.filters) {
                    
                    self.glGeocoderHelper.addCoordinates(members: membersFiltered, completion: { membersLocated in
                        self.members = membersLocated
                    })
                }
            default:
                break
            }
        })
    }
    
    func didPressInfoLogo() {
        delegate?.didPressFFVELogo()
    }
    
    func didSelectMember(member: MemberItem) {
        delegate?.seeMemberDetail(member: member)
    }
    
    func didClickOnMember(memberName: String) {
        let chosenMember = members.filter { $0.name == memberName}
        delegate?.seeMemberDetail(member: chosenMember[0])
    }
    
    // MARK: - Private methods
    
    private func filter(from memberArray: [MemberItem], with filter: FiltersItem) -> [MemberItem]? {
        
        var result: [MemberItem] = memberArray
        
        if let department = filter.department {
            zoomType?(.department)
            result = result.filter{ $0.department_no == department }
        }
        
        if let cities = filter.city {
            zoomType?(.city)
            result = result.filter{ $0.city.firstCharacterUpperCase().contains(cities)}
        }
        
        if filter.city == nil && filter.department == nil {
            zoomType?(.none)
        }
        
        if let filterType = filter.type {
            switch filterType {
            case .auto(nil):
                result = result.filter{ $0.college == "Marques" || $0.college == "Multimarques" }
            case .auto(let brand):
                result = result.filter{ $0.category == brand?.rawValue }
            case .moto:
                result = result.filter{ $0.category == "Motocyclettes"}
            case .camion:
                result = result.filter{ $0.category == "Camions"}
            case .museum:
                result = result.filter{
                    $0.college == "Musées"
                }
            case .utilitaire:
                result = result.filter{
                    $0.college == "Utilitaires, Militaires, Agricoles"
                }
            case .professional(nil):
                result = result.filter{
                    $0.college == "Professionnels"
                }
            case .professional(let speciality):
                result = result.filter{
                    $0.category == speciality?.rawValue
                }
            default:
                break
            }
        }
        guard result != [] else {activityIndicatorIsHidden?(true); delegate?.alert(type: .noMember) ; return nil}
        return result
    }
}
