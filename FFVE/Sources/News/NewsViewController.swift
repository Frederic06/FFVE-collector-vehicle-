//
//  TotemViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import WebKit

final class NewsViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var videoTable: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var viewModel: NewsViewModel!
    
    private var videoDataSource: VideoDataSource?
    
    
    // MARK: - View life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        videoDataSource = VideoDataSource(tableView: videoTable)
        
        videoTable.dataSource = videoDataSource
        videoTable.delegate = videoDataSource
        
        bind(to: viewModel)
        viewModel.viewDidAppear()
        setNavBar()
        bind(to: videoDataSource!)
        
        indicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
    }
    
    // MARK: - Private methods
    
    private func bind(to viewModel: NewsViewModel) {
        viewModel.videos = { [weak self] item in
            DispatchQueue.main.async {
                self?.videoDataSource?.update(with: item)
                self?.videoTable.reloadData()
            }
        }
    }
    
    private func setPlayer(videoID: String) {
        
    }
    
    private func bind(to dataSource: VideoDataSource) {
        dataSource.didSelect = viewModel.didSelect
    }
    
    private func setNavBar() {
        self.navigationItem.title = "Vidéos Youtube"
        
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func buttonInfoTapped() {
        viewModel.didPressInfoLogo()
    }
}
