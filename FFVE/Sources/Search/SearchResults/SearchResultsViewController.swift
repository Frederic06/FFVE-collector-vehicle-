//
//  ClubResearchViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import MapKit

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapResult: MKMapView!
    
    @IBOutlet weak var tableResult: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
    
    var viewModel: SearchResultsViewModel!
    
    private var tableResultDataSource = TableResultDataSource()
    
    private var mapDataSource: MapDataSource?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        mapDataSource = MapDataSource(map: mapResult)
        mapResult.delegate = mapDataSource
        
        tableResult.dataSource = tableResultDataSource
        tableResult.delegate = tableResultDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapResult.isHidden = true
        bind(to: viewModel)
        bind(to: tableResultDataSource)
        bind(to: mapDataSource!)
        viewModel.viewDidAppear()
    }
    
    //        MARK: - Private methods
    
    private func bind(to viewModel: SearchResultsViewModel) {
        
        viewModel.memberArray = { [weak self] members in
            self?.tableResultDataSource.update(members: members)
            self?.tableResult.reloadData()
            self?.mapDataSource?.constructItems(with: members)
        }
        
        viewModel.zoomType = { [weak self] zoom in
            self?.mapDataSource?.updateZoom(centeredOn: zoom)
        }
        
        viewModel.activityIndicatorIsHidden = { [weak self] state in
            if state == false {
                self?.activityIndicator.startAnimating()
                
            } else {
                self?.activityIndicator.stopAnimating()
            }
            self?.activityIndicator.isHidden = state
        }
        
        viewModel.tableHidden = { [weak self] state in
            self?.tableResult.isHidden = state
        }
    }
    
    private func bind(to dataSource: TableResultDataSource) {
        dataSource.didSelectMember = viewModel.didSelectMember
    }
    
    // Segmented Control
    
    @objc private func segmentChanged() {
        if tableResult.isHidden == true {
            tableResult.isHidden = false
            mapResult.isHidden = true
        }
        else {
            tableResult.isHidden = true
            mapResult.isHidden = false
        }
    }
    
    private func bind(to map: MapDataSource) {
        map.chosenMember = viewModel.didClickOnMember
    }
}

extension SearchResultsViewController {
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.4059926867, green: 0.3586520553, blue: 0.7986440063, alpha: 1)
        let ffveButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = ffveButton
    }
    
    @objc private func rightButtonTapped() {
        viewModel.didPressInfoLogo()
    }
    
    private func setUI() {
        activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        setupSegmentedControl()
        setNavigationBar()
    }
    
    private func setupSegmentedControl() {
        let titles = ["Liste ", "Carte "]
        let segmentControl = UISegmentedControl(items: titles)
        
        segmentControl.tintColor = UIColor.white
        segmentControl.backgroundColor = #colorLiteral(red: 0.2429448962, green: 0.6767920256, blue: 0.9522953629, alpha: 1)
        segmentControl.selectedSegmentIndex = 0
        for index in 0...titles.count-1 {
            segmentControl.setWidth(120, forSegmentAt: index)
        }
        segmentControl.sizeToFit()
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.sendActions(for: .valueChanged)
        navigationItem.titleView = segmentControl
    }
}
