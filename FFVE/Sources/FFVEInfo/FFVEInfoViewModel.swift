//
//  FFVEInfoViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

enum FunctionCase: String {
    case search = "La fonctionnalité présente permet la recherche d'un membre et sa localisation. Saisissez un nom d'adhérent ou de ville dans la barre supérieure, ou laissez vous guider par les boutons sur la page principale.", events = "Le calendrier présente dans un ordre chronologique les événements auxquels participera la Fédération Française des Véhicules d'Epoque, cliquez sur un événement pour obtenir sa description", video = "Visualisez les vidéos mises en ligne par la fédération sur sa chaine Youtube. Cliquez sur une vidéo afin de démarrer la lecture."
}

enum Button: String, Equatable {
    case history = "Histoire de la fédération", inscriptions = "Inscription", dev = "A propos du développeur", video, globe, image
    
    static func ==(lhs: Button, rhs: Button) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

final class FFVEInfoViewModel{
    
    var buttonsTitle: (([String]) -> Void)?
    
    var buttons: (([Button]) -> Void)?
    
    var functionDescriptionText: ((String) -> Void)?
    
    var functionCase: FunctionCase
    
    var openWebPage: ((String) -> Void)?
    
    private weak var delegate: CoordinatorsDelegate?
    
    init(function: FunctionCase, delegate: CoordinatorsDelegate) {
        self.functionCase = function
        self.delegate = delegate
    }
    
    func viewDidAppear() {
        buttons?([.history, .inscriptions, .dev])
        buttonsTitle?(["Histoire de la fédération","Conditions générales","A propos du développeur"])
        
        functionDescriptionText?(functionCase.rawValue)
    }
    
    func didPressX() {
        delegate?.dismissed()
    }
    
    func didPress(button: Button) {
        switch button {
        case .history:
            openWebPage?("https://www.ffve.org/Histoire_de_la_FFVE")
        case .inscriptions:
            openWebPage?("https://www.ffve.org/Comment_adherer_a_la_FFVE")
        case .dev:
            openWebPage?("https://frederic06.github.io/Demo/")
        case .image:
            openWebPage?("https://www.flickr.com/photos/146458637@N06/albums")
        case .globe:
            openWebPage?("https://www.ffve.org/")
        case .video:
            openWebPage?("https://www.youtube.com/channel/UCPapD6dD5H64yRFzv20K8lQ")
        }
    }
}
