
//
//  CityMemberTable.swift
//  FFVE
//
//  Created by Margarita Blanc on 01/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class CityMemberTableDataSource: NSObject{
    
    private var cities: [City]?
    
    private var members: [MemberItem]?
    
    let sectionHeaderHeight: CGFloat = 25
    
    var selectedCity: ((String) -> Void)?
    
    var selectedMember: ((MemberItem) -> Void)?
    
    func setCities(cities: [City]) {
        self.cities = cities
    }
    
    func setMembers(members:[MemberItem]) {
        self.members = members
    }
}

extension CityMemberTableDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return cities?.count ?? 0
        case 1:
            return members?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return sectionHeaderHeight
        case 1:
            return sectionHeaderHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: sectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        switch section {
        case 0:
            label.text = "Ville"
        case 1:
            label.text = "Adhérent"
        default:
            label.text = ""
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = cities?[indexPath.row].cityName
            }
            if let subtitleLabel = cell.viewWithTag(2) as? UILabel {
                if let cityDepartment = cities?[indexPath.row].departmentNumber {
                    switch cityDepartment.count {
                    case 1:
                        subtitleLabel.text = "0\(cityDepartment)"
                    default:
                        subtitleLabel.text = cities?[indexPath.row].departmentNumber
                    }
                }
            }
        case 1:
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = members?[indexPath.row].name
            }
            if let subtitleLabel = cell.viewWithTag(2) as? UILabel {
                subtitleLabel.text = members?[indexPath.row].city
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let city = cities?[indexPath.row].cityName else { return }
            selectedCity?(city)
        case 1:
            guard let member = members?[indexPath.row] else { return }
            selectedMember?(member)
        default:
            break
        }
    }
}
