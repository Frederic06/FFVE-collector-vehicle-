//
//  TableChoiceDataSource.swift
//  FFVE
//
//  Created by Frédéric Blanc on 05/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class TableChoiceDataSource: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    private var choiceArray: [String]?
    
    private var buttons: [Button]?
    
    var selectedButton: ((Button) -> Void)?
    
    func update(array: [String]) {
        self.choiceArray = array
    }
    
    func update(buttons: [Button]) {
        self.buttons = buttons
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let buttons = buttons else { return 0}
        return buttons.count+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let buttonNumber = buttons?.count else {return 0}
        
        if indexPath.row == buttonNumber {
            return 150
        } else {
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
            guard let buttonTitle = buttons?[indexPath.row].rawValue else { return cell }
            if let button = cell.viewWithTag(1) as? UIButton {
                button.setRounded(color: #colorLiteral(red: 0.3115793765, green: 0.2650237381, blue: 0.7776248455, alpha: 1))
                button.setTitle(buttonTitle, for: .normal)
                switch indexPath.row {
                case 0:
                    button.addTarget(self, action: #selector(firstButtonPressed(sender:)), for: .touchUpInside)
                    return cell
                case 1:
                    button.addTarget(self, action: #selector(secondButtonPressed(sender:)), for: .touchUpInside)
                    return cell
                case 2:
                    button.addTarget(self, action: #selector(thirdButtonPressed(sender:)), for: .touchUpInside)
                    return cell
                default:
                    break
                }
            }
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowCell", for: indexPath)
            if let label = cell.viewWithTag(6) as? UILabel {
                label.text = "Suivre la fédération"
            }
            if let button = cell.viewWithTag(2) as? UIButton {
                button.addTarget(self, action: #selector(flickrClicked(sender:)), for: .touchUpInside)
            }
            if let button = cell.viewWithTag(3) as? UIButton {
                button.addTarget(self, action: #selector(globeClicked(sender:)), for: .touchUpInside)
            }
            if let button = cell.viewWithTag(4) as? UIButton {
                button.addTarget(self, action: #selector(youtubeClicked(sender:)), for: .touchUpInside)
            }
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    @objc fileprivate func firstButtonPressed(sender: UIButton) {
        guard let button = buttons?[0] else { return }
        selectedButton?(button)
    }
    
    @objc fileprivate func secondButtonPressed(sender: UIButton) {
        guard let button = buttons?[1] else { return }
        selectedButton?(button)
    }
    
    @objc fileprivate func thirdButtonPressed(sender: UIButton) {
        guard let button = buttons?[2] else { return }
        selectedButton?(button)
    }
    
    @objc fileprivate func flickrClicked(sender: UIButton) {
        print("flickrClicked")
    }
    
    @objc fileprivate func globeClicked(sender: UIButton) {
        print("globeClicked")
    }
    
    @objc fileprivate func youtubeClicked(sender: UIButton) {
        print("youtubeClicked")
    }
}
