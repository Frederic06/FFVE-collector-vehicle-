//
//  Route.swift
//  FFVE
//
//  Created by Margarita Blanc on 04/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

enum Request {
    case members, photos, homePhotos, events, youtube
}

final class Route {
    private let membersURLString = "https://ffve.fr/backoffice/admin/tojson.php?token=88375A95222F5D656CB517E2B2D71&option=adh_all"
    
    private let homeAlbumURLString = "https://www.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=77f968e96f494323bcd573c0cdc929a4&photoset_id=72157711962163342&user_id=184914783%40N07&format=json&nojsoncallback=1"
    
    private let albumURLString =  "https://www.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=77f968e96f494323bcd573c0cdc929a4&photoset_id=72157711751500108&user_id=184914783%40N07&format=json&nojsoncallback=1"
    
    private let apiKey = "77f968e96f494323bcd573c0cdc929a4"
    
    private let userID = "184914783@N07"
    
    private let agendaUrlString = "https://openagenda.com/agendas/43187170/events.json"
    
    private let youtupeAPIKey = "AIzaSyAvK39faJYtd1pM6sEbKG3ahRCuEwBYaIA"
    private let youtubeRequestString = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyAvK39faJYtd1pM6sEbKG3ahRCuEwBYaIA&channelId=UCPapD6dD5H64yRFzv20K8lQ&part=snippet&maxResults=20&order=date&type=video"
    // 20 vidéos
}

// MARK: - URL Return
extension Route {
    
    func getURL(request: Request) -> URL? {
        var urlString: String
        switch request {
        case .members:
            urlString = membersURLString
        case .photos:
            urlString = albumURLString
        case .homePhotos:
            urlString = homeAlbumURLString
        case .events:
            urlString = agendaUrlString
        case .youtube:
            urlString = youtubeRequestString
        }

        return URL(string: urlString)
    }
    
    func memberRequestURL() -> URL? {
        return URL(string: membersURLString)
    }
}
