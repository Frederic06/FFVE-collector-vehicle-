//
//  VideoCell.swift
//  FFVE
//
//  Created by Margarita Blanc on 27/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import WebKit

final class VideoCell: UITableViewCell, WKNavigationDelegate {
    
    private var viewModel: CellViewModel?
    
    private let appGroupName = "br.com.tntstudios.youtubeplayer"
    
    private var video: VideoItem? = nil {
        didSet {
            guard let item = video else {return}
            guard let snipper = item.highSnipper else {return}
            guard let url = URL(string: snipper) else {return}
            if let data = try? Data( contentsOf: url) {
                guard let image = UIImage(data: data) else {return}
                self.videoScreen.image = image
            }
            titleLabel.text = item.title
            let date = String(item.publishedAt.prefix(10)).changeDateFormat()
            authorTitle.text = date
        }
    }
    
    private func loadYoutubeIframe(youtubeVideoId: String) {
        let html =
            "<html>" +
                "<body style='margin: 0;'>" +
                "<script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>" +
                "<script type='text/javascript'> " +
                "   function onYouTubeIframeAPIReady() {" +
                "      ytplayer = new YT.Player('playerId',{events:{'onReady': onPlayerReady, 'onStateChange': onPlayerStateChange}}) " +
                "   } " +
                "   function onPlayerReady(a) {" +
                "       window.location = 'br.com.tntstudios.youtubeplayer://state=6'; " +
                "   }" +
                "   function onPlayerStateChange(d) {" +
                "       window.location = 'br.com.tntstudios.youtubeplayer://state=' + d.data; " +
                "   }" +
                "</script>" +
                "<div style='justify-content: center; align-items: center; display: flex; height: 100%;'>" +
                "   <iframe id='playerId' type='text/html' width='100%' height='100%' src='https://www.youtube.com/embed/\(youtubeVideoId)?" +
                "enablejsapi=1&rel=0&playsinline=0&autoplay=0&showinfo=0&modestbranding=1' frameborder='0'>" +
                "</div>" +
                "</body>" +
        "</html>"
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func bind(to viewModel: CellViewModel) {
        
        viewModel.webViewHidden = { [weak self] state in
            self?.webView.isHidden = state
        }
        viewModel.videoItem = { [weak self] item in
            self?.video = item
        }
        viewModel.play = { [weak self] in
            guard let id = self?.video?.videoId else {return}
            self?.loadYoutubeIframe(youtubeVideoId: id)
        }
        
        viewModel.imageHidden = { [weak self] state in
            self?.videoScreen.isHidden = state
        }
    }
    
    @IBOutlet weak var videoScreen: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorTitle: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    func configureCell(viewModel: CellViewModel) {
        self.viewModel = viewModel
        webView.navigationDelegate = self
        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        guard let url = navigationAction.request.url else {return}
        
        if url.absoluteString.contains("https://www.youtube.com/watch") {
            return
        }
        
        if url.scheme == appGroupName {
            
            if let playerState = url.absoluteString.components(separatedBy: "=").last {
                
                // iframe API reference: https://developers.google.com/youtube/iframe_api_reference
                
                // -1 – unstarted
                // 0 – ended
                // 1 – playing
                // 2 – paused
                // 3 – buffering
                // 5 – video cued
                // 6 - ready
                
                switch playerState {
                case "-1":
                    print("video State: unstarted")
                    break
                case "0":
                    print("video State: ended")
                case "1":
                    print("video State: playing")
                case "2":
                    print("video State: paused")
                case "3":
                    print("video State: buffering")
                case "5":
                    print("video State: video cued")
                case "6":
                    viewModel?.PlayerReady()
                    print("video State: ready")
                default:
                    print("video State: LOL")
                }
            }
        }
        decisionHandler(.allow)
    }
}
