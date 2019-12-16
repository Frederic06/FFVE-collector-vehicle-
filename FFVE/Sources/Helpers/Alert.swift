//
//  Alert.swift
//  FFVE
//
//  Created by Frédéric Blanc on 21/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum AlertType {
    case networkError, noMember, memberType, club
}

struct Alert {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "Attention", message: "Mauvaise connexion internet 😱")
        case .noMember:
            self = Alert(title: "Aucun adhérent ne correspond à votre recherche 😢 ", message: "")
        case .club:
            self = Alert(title: "Quel type de club souhaitez-vous rechercher?", message: "")
        case .memberType:
            self = Alert(title: "Quel type d'adhérent souhaitez-vous rechercher?", message: "")
        }
    }
}
