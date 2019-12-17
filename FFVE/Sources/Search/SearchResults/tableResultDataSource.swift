//
//  tableResultDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class TableResultDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var members : [MemberItem]?
    
    var didSelectMember: ((MemberItem) -> Void)?
    
    func update(members: [MemberItem]) {
        self.members = members
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let memberItems = members else {return 0}
        return memberItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as? MemberCell else {return UITableViewCell()}
        guard let member = members?[indexPath.row] else {return cell}
        cell.updateCell(with: member)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let member = members?[indexPath.row] else {return }
        didSelectMember?(member)
    }
}
