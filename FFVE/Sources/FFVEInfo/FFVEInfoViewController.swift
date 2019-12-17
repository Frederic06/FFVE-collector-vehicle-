//
//  FFVEInfoViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class FFVEInfoViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableChoice: UITableView!
    
    private var tableChoiceDataSource = TableChoiceDataSource()
    // MARK: - Properties
    
    @IBOutlet weak var functionDescription: UILabel!
    
    var viewModel: FFVEInfoViewModel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        bind(to: tableChoiceDataSource)
        viewModel.viewDidAppear()
        self.tableChoice.dataSource = tableChoiceDataSource
        self.tableChoice.delegate = tableChoiceDataSource
    }
    
    private func bind(to viewModel: FFVEInfoViewModel) {
        viewModel.buttonsTitle = { [weak self] titles in
            self?.tableChoiceDataSource.update(array: titles)
            self?.tableChoice.reloadData()
        }
        
        viewModel.functionDescriptionText = { [weak self] text in
            self?.functionDescription.text = text
        }
        
        viewModel.buttons = { [weak self] array in
            self?.tableChoiceDataSource.update(buttons: array)
            self?.tableChoice.reloadData()
        }
        
        viewModel.openWebPage = { adress in
            if let url = URL(string: adress) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func bind(to dataSource: TableChoiceDataSource) {
        dataSource.selectedButton = viewModel.didPress
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButton(_ sender: UIButton) {
        viewModel.didPressX()
    }
}
