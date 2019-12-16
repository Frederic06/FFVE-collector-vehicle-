//
//  DepartmentPickerDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 23/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class DepartmentPickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var itemArray: [String]? = []
    
    var didSelectItem: ((String) -> Void)?
    
    func updateDepartments(departments: [String]) {
        self.itemArray = departments
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let number = itemArray?.count else {return 0}
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemArray?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let item = itemArray?[row] else {self.didSelectItem?("");return}
        self.didSelectItem?(item)
    }
}
