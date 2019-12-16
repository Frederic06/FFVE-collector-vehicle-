//
//  DepartmentDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 24/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class VideoDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var videos : [VideoItem]?
    
    private let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    var didSelect:((VideoItem) -> Void)?
    
    func update(with videos: [VideoItem]) {
        self.videos = videos
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let videoItems = videos else {return 0}
        return videoItems.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 269
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoCell
        guard let video = videos?[indexPath.row] else {return cell}
        let viewModel = CellViewModel(video: video, index: indexPath.row)
        cell.configureCell(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let video = self.videos?[indexPath.row] else {return}
        didSelect?(video)
    }
}
