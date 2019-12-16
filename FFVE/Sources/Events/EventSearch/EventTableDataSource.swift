//
//  EventTableDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 10/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class EventTableDataSource: NSObject {
    
    private var table: UITableView
    
    private var converter = DateConverter()
    
    private var events: [EventItem] = []
    
    private var filteredEvents: [EventItem] = []
    
    private var headers: [String] = []
    
    private var monthsYearForFilter: [String] = []
    
    init(table: UITableView) {
        self.table = table
        super.init()
        
        table.dataSource = self
        table.delegate = self
    }
    
    var didChooseEvent: ((EventItem) -> Void)?
    
    func updateCells(with events: [EventItem]) {
        self.events = converter.sort(events: events)
        makeHeaderArray()
        makeFilterArray()
        table.reloadData()
    }
}

extension EventTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = checkNumberOfSections()
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = getNumberOfRows(for: section)
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        filterEvents(at: indexPath.section)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let event = filteredEvents[indexPath.row]
        
        cell.updateCell(with: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard headers != [] else {return nil}
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 35.0)! ]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 150))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 15, y: -25, width: tableView.bounds.width - 30, height: 100))
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 0.377325654, green: 0.336207211, blue: 0.7377319932, alpha: 1)
        label.textAlignment = .left
        let myAttrString = NSAttributedString(string: headers[section], attributes: myAttribute)
        label.attributedText = myAttrString
        
        view.addSubview(label)
        return view
    }
    
    private func checkNumberOfSections() -> Int {
        guard headers != [] else {return 0}
        
        var numberOfSections: Int = headers.count
        
        let (month, year) = converter.getDategetDateMonthYearShort()
        let monthArray = getArray(currentMonth: month, year: year)
        
        var dateEvents: [EventItem]
        
        for i in 0 ..< monthArray.count {
            let stringInt = monthArray[i]
            
            dateEvents = events.filter {
                $0.firstDate.transformToMonthYearString() == stringInt}
            
            if dateEvents.count == 0 {
                numberOfSections -= 1
                headers.remove(at: i)
                monthsYearForFilter.remove(at: i)
            }
        }
        return numberOfSections
    }
    
    private func getNumberOfRows(for section: Int) -> Int {
        guard headers != [] else {return 0}
        let monthYearString = monthsYearForFilter[section]
        
        let number = events.filter {
            $0.firstDate.transformToMonthYearString() == monthYearString}
        return number.count
        
    }
    
    private func makeFilterArray() {
        let (month, year) = converter.getDategetDateMonthYearShort()
        let filterArray = getArray(currentMonth: month, year: year)
        monthsYearForFilter = filterArray
    }
    
    private func makeHeaderArray() {
        let (month, year) = converter.getDateMonthYear()
        if let array = getMonths(currentMonth: month, currentYear: year) {
            self.headers = array
        }
    }
    
    private func filterEvents(at index: Int) {
        
        let month = monthsYearForFilter[index]
        
        filteredEvents = events.filter {
            $0.firstDate.transformToMonthYearString() == month}
    }
}

extension EventTableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterEvents(at: indexPath.section)
        
        let choice = filteredEvents[indexPath.row]
        didChooseEvent?(choice)
    }
}

extension EventTableDataSource {
    
    func getMonths(currentMonth: String, currentYear: String) -> [String]?{
        guard let intYear =  Int(currentYear) else { return []}
        let nextYearString = String(intYear+1)
        
        switch currentMonth {
        case "01":
            return ["Janvier \(currentYear)", "Février \(currentYear)", "Mars \(currentYear)", "Avril \(currentYear)", "Mai \(currentYear)", "Juin \(currentYear)", "Juillet \(currentYear)"]
        case "02":
            return ["Février \(currentYear)", "Mars \(currentYear)", "Avril \(currentYear)", "Mai \(currentYear)", "Juin \(currentYear)", "Juillet \(currentYear)", "Août \(currentYear)"]
        case "03":
            return ["Mars \(currentYear)", "Avril \(currentYear)", "Mai \(currentYear)", "Juin \(currentYear)", "Juillet \(currentYear)", "Août \(currentYear)", "Septembre \(currentYear)"]
        case "04":
            return ["Avril \(currentYear)", "Mai \(currentYear)", "Juin \(currentYear)", "Juillet \(currentYear)", "Août \(currentYear)", "Septembre \(currentYear)", "Octobre \(currentYear)"]
        case "05":
            return ["Mai \(currentYear)", "Juin \(currentYear)", "Juillet \(currentYear)", "Août \(currentYear)", "Septembre \(currentYear)", "Octobre \(currentYear)", "Novembre \(currentYear)"]
        case "06":
            return ["Juin \(currentYear)", "Juillet \(currentYear)", "Août \(currentYear)", "Septembre \(currentYear)", "Octobre \(currentYear)", "Novembre \(currentYear)", "Décembre \(currentYear)"]
        case "07":
            return ["Juillet \(currentYear)", "Août \(currentYear)", "Septembre \(currentYear)", "Octobre \(currentYear)", "Novembre \(currentYear)", "Décembre \(currentYear)", "Janvier \(nextYearString)"]
        case "08":
            return ["Août \(currentYear)", "Septembre \(currentYear)", "Octobre \(currentYear)", "Novembre \(currentYear)", "Décembre \(currentYear)", "Janvier \(nextYearString)", "Février \(nextYearString)"]
        case "09":
            return ["Septembre \(currentYear)", "Octobre \(currentYear)", "Novembre \(currentYear)", "Décembre \(currentYear)", "Janvier \(nextYearString)", "Février \(nextYearString)", "Mars \(nextYearString)"]
        case "10":
            return ["Octobre \(currentYear)", "Novembre \(currentYear)", "Décembre \(currentYear)", "Janvier \(nextYearString)", "Février \(nextYearString)", "Mars \(nextYearString)", "Avril \(nextYearString)"]
        case "11":
            return ["Novembre \(currentYear)", "Décembre \(currentYear)", "Janvier \(nextYearString)", "Février \(nextYearString)", "Mars \(nextYearString)", "Avril \(nextYearString)", "Mai \(nextYearString)"]
        case "12":
            return ["Décembre \(currentYear)", "Janvier \(nextYearString)", "Février \(nextYearString)", "Mars \(nextYearString)", "Avril \(nextYearString)", "Mai \(nextYearString)", "Juin \(nextYearString)"]
        default:
            return nil
        }
    }
    
    func getArray(currentMonth: String, year: String) -> [String] {
        guard let intYear =  Int(year) else { return []}
        let nextYearString = String(intYear+1)
        
        switch currentMonth {
        case "01":
            return ["01-\(intYear)","02-\(intYear)","03-\(intYear)","04-\(intYear)","05-\(intYear)","06-\(intYear)","07-\(intYear)"]
            
        case "02":
            return ["02-\(intYear)","03-\(intYear)","04-\(intYear)","05-\(intYear)","06-\(intYear)","07-\(intYear)","08-\(intYear)"]
            
        case "03":
            return ["03-\(intYear)","04-\(intYear)","05-\(intYear)","06-\(intYear)","07-\(intYear)","08-\(intYear)","09-\(intYear)"]
            
        case "04":
            return ["04-\(intYear)","05-\(intYear)","06-\(intYear)","07-\(intYear)","08-\(intYear)","09-\(intYear)","10-\(intYear)"]
            
        case "05":
            return ["05-\(intYear)","06-\(intYear)","07-\(intYear)","08-\(intYear)","09-\(intYear)","10-\(intYear)","11-\(intYear)"]
            
        case "06":
            return ["06-\(intYear)","07-\(intYear)","08-\(intYear)","09-\(intYear)","10-\(intYear)","11-\(intYear)","12-\(intYear)"]
            
        case "07":
            return ["07-\(intYear)","08-\(intYear)","09-\(intYear)","10-\(intYear)", "11-\(intYear)","12-\(intYear)","01-\(nextYearString)"]
            
        case "08":
            return ["08-\(intYear)","09-\(intYear)","10-\(intYear)", "11-\(intYear)", "12-\(intYear)","01-\(nextYearString)","02-\(nextYearString)"]
            
        case "09":
            return ["09-\(intYear)","10-\(intYear)", "11-\(intYear)", "12-\(intYear)","01-\(nextYearString)","02-\(nextYearString)","03-\(nextYearString)"]
            
        case "10":
            return ["10-\(intYear)","11-\(intYear)", "12-\(intYear)","01-\(nextYearString)", "02-\(nextYearString)","03-\(nextYearString)","04-\(nextYearString)"]
            
        case "11":
            return ["11-\(intYear)", "12-\(intYear)","01", "02-\(nextYearString)","03-\(nextYearString)","04-\(nextYearString)","05-\(nextYearString)"]
            
        default:
            return ["12-\(intYear)","01-\(nextYearString)", "02-\(nextYearString)","03-\(nextYearString)","04-\(nextYearString)","05-\(nextYearString)","06-\(nextYearString)"]
        }
    }
}
