//
//  Extensions.swift
//  FFVE
//
//  Created by Frédéric Blanc on 18/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

extension String {
    func firstCharacterUpperCase() -> String {
        let lowercaseString = self.lowercased()
        return lowercaseString.capitalizingFirstLetter()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension String {
    func changeDateFormat() -> String{
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputDateFormatter.date(from: self) else {return ""}
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM/yyyy"
        let finalDate = outputDateFormatter.string(from: date)
        return finalDate
    }
}

extension String {
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date
        }
        return nil
    }
}

extension Event {
    func transformToDated() -> ([EventItem])? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var datedEvents: [EventItem] = []
        
        for event in self.events {
            guard let firstDate = dateFormatter.date(from: event.firstDate) else {return nil}
            guard let lastDate = dateFormatter.date(from: event.lastDate) else {return nil}
            let datedEvent = EventItem(title: event.title.fr, description: event.description.fr, longDescription: event.longDescription.fr, image: event.image, locationName: event.locationName, firstDate: firstDate, lastDate: lastDate, thumbnail: event.thumbnail, eventUrl: event.registrationUrl, longitude: event.longitude, latitude: event.latitude)
            
            datedEvents.append(datedEvent)
        }
        return datedEvents
    }
}

extension Date {
    func transformToDayString() -> String {
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd"
        let finalDate = outputDateFormatter.string(from: self)
        
        return finalDate
    }
    
    func transformToMonthString() -> String {
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MM"
        let finalDate = outputDateFormatter.string(from: self)
        
        return finalDate
    }
    
    func transformToDayMonthString() -> String {
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM"
        let finalDate = outputDateFormatter.string(from: self)
        
        return finalDate
    }
    
    func transformToMonthYearString() -> String {
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MM-yy"
        let finalDate = outputDateFormatter.string(from: self)
        
        return finalDate
    }
}

extension EventItem {
    func transformDateToNiceString() -> String{
        if self.firstDate != self.lastDate {
            return "Du \(self.firstDate.transformToDayMonthString()) au \(self.lastDate.transformToDayMonthString())"
        } else {
            return "Le \(self.firstDate.transformToDayMonthString())"
        }
    }
}

extension UIButton{
    func setRounded(color: UIColor) {
        self.contentHorizontalAlignment = .center
        self.backgroundColor = color
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        
        tap.cancelsTouchesInView = false
        return tap
    }
}
extension EventItem {
    enum Error: Swift.Error, Equatable {
        case emptyText
        case tooManyWords(count: Int)
        case unknownWords([String])
    }
}

extension String{
    func getMemberTypeLabelText() -> String{
    switch self {
               case "Professionnels":
                   return "Type de membre: Professionnel"
                   
               case "Multimarques", "Marques":
                   return "Type de membre: Club"
               case "Musées":
                   return "Type de membre: Musée"
               default:
                   return "Type de membre: \(self)"
               }
    }
}



