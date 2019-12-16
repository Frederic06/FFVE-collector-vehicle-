//
//  Filters.swift
//  FFVE
//
//  Created by Frédéric Blanc on 21/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

enum MemberType{
    case all, club, auto(Brand?), moto, camion, utilitaire, museum, professional(Speciality?)
}

extension MemberType: RawRepresentable {
    
    public typealias RawValue = String
    
    /// Failable Initalizer
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "Tous les adhérents":  self = .all
        case "Order 2":  self = .club
        default:
            return nil
        }
    }
    
    /// Backing raw value
    public var rawValue: RawValue {
        switch self {
        case .all: return "Tous les adhérents"
        case .club:   return "Tous les clubs"
        case .auto: return "Clubs auto"
        case .moto: return "Clubs moto"
        case .camion: return "Clubs camion"
        case .utilitaire: return "Clubs utilitaire"
        case .museum: return "Musées"
        case .professional: return "Professionnels"
        }
    }
}

extension MemberType: Equatable {
    static func == (lhs: MemberType, rhs: MemberType) -> Bool {
        switch (lhs, rhs) {
        case (.auto(let a), .auto(let b)):
            return a == b
        case (.club, .club):
            return lhs == rhs
        case (.professional(let a), .professional(let b)):
            return a == b
        case (.museum, .museum):
            return lhs == rhs
        case (.camion, .camion):
            return lhs == rhs
        case (.moto, .moto):
            return lhs == rhs
        case (.utilitaire, .utilitaire):
            return lhs == rhs
        default: return false
        }
    }
}

enum Filter{
    case department, speciality, brand
}

enum ZoomType: Double {
    case department = 50000, city = 10000, none = 0
}

enum Speciality: String, Equatable, CaseIterable {
    case none = "Toutes", accessoiresDivers = "Accessoires Divers (Plaques, Insignes..)", achatventenegoce = "Achat, Vente, Négoce",  allumage,Électricité = "Allumage, Carburation, Freinage, Électricité", artAutomobile = "Art Automobile",
    assurance = "Assurance", avocatSpécialisé = "Avocat spécialisé", carrosseriesAccessoires = "Carrosseries et Accessoires", Circuits = "Circuits, Écoles De Pilotage, Stage De Conduite", constructeursImportateurs = "Constructeurs-Importateurs", contrôle = "Contrôle technique", echappements = "Echappements", editeur = "Editeur", enchere = "Enchères Commissaires-Priseurs", ExpertsAutoMoto = "Experts Auto Moto", ExpertsAutomobile = "Experts En Automobile", formationMecanique = "Formation Mécanique Véhicules De Collection", furnituresAutomobiles = "Fournitures Automobiles Et Industrielles", location = "location", mecaniqueGenerale = "Mécanique Générale", organnisation = "Organisation Événementiel", outil = "Outils Et Matériel Spécial", parking = "Parkings-Garages-Gardiennage", piece = "Pièces détachées", pneu = "Pneumatique", restauration = "Restauration", sellerie = "Sellerie, Housses, Capotes", service = "Services Divers, Internet", spécialistesAmericaines = "Spécialistes Americaines", specialistesAnglaises = "Spécialistes Anglaises", specialistesFrançaise = "Spécialistes Francaises", specialistesItalienne = "Spécialistes Italiennes", specialiistesMoto = "Spécialistes Motos", specialistesSpeciales = "Spécialistes Sportives Et Spéciales", specialistesMarques = "Spécialistes Toutes Marques", tourisme = "Tourisme", traitementDesMécaniques = "Traitement Des Mécaniques", transitaire = "Transitaire", transportMaritime = "Transport maritime", transportRemorquage = "Transports-Remorquage", vêtementsEtAccessoires = "Vêtements et accessoires"
}

enum Brand: String, Equatable, CaseIterable {
    case none = "Toutes", alphaRomeo = "Alfa Romeo", alpine = "Alpine", amilcar = "Amilcar", astonMartin = "Aston Martin", austinHealey = "Austin Healey", bmw = "B.M.W.", bnc = "B.N.C.", bentley = "Bentley", Bernardet = "Bernardet", bugatti = "Bugatti", cg = "C.G.", cadillac = "Cadillac", chenardEtWalker = "Chenard et Walker", chevrolet = "Chevrolet", chevron = "Chevron", citroen = "Citroen", db = "D.B.", deDionBouton = "De Dion Bouton", deLorean = "De Lorean", delage = "Delage", delahaye = "Delahaye", delaugereEtClayette = "Delaugere et Clayette", facelVega = "Facel Véga", ferrari = "Ferrari", fiat = "Fiat", ford = "Ford", gordini = "Gordini", georgesIrat = "Georges Irat", gregoire = "Gregoire", hispanoSuiza = "Hispano Suiza", honda = "Honda", hotchkiss = "Hotchkiss", jaguar = "Jaguar", laLicorne = "La Licorne", labourier = "Labourier", lancia = "Lancia", ligier = "Ligier", lorraineDietrich = "Lorraine Dietrich", lotus = "Lotus", marcadier = "Marcadier", maserati = "Maserati", matford = "Matford", mathis = "Mathis", matra = "Matra", mazda = "Mazda", mercedes = "Mercedes", mg = "MG", morgan = "Morgan", morris = "Morris", nsu = "NSU", opel = "Opel", panhardLevassor = "Panhard Levassor", peugeot = "Peugeot", porsche = "Porsche", renault = "Renault", rollandPilain = "Rolland Pilain", rollsRoyce = "Rolls Royce", rosengart = "Rosengart", rover = "Rover", salmson = "Salmson", simca = "Simca", studebaker = "Studebaker", Sunbeam = "Sunbeam", talbot = "Talbot", triumph = "Triumph", voisin = "Voisin", volkswagen = "Volkswagen", volvo = "Volvo"
}

enum Department: String, Equatable, CaseIterable {
    case none = "Tous", ain = "01 : Ain", aisne = "02 : Aisne", allier = "03 : Allier", alpesHauteProvence = "04 : Alpes-de-Haute-Provence", hautesAlpes = "05 : Hautes-Alpes", alpesMaritimes = "06 : Alpes-Maritimes", ardeche = "07 Ardèche",Ardennes = "08 : Ardennes",Ariège = "09 : Ariège", Aube = "10 : Aube", Aude = "11 : Aude", aveyron = "12 : Aveyron", bouchesDuRhône = "13 : Bouches-du-Rhône", calvados = "14 : Calvados", cantal = "15 : Cantal", charente = "16 : Charente", charenteMaritime = "17 : Charente-Maritime", cher = "18 : Cher", correze = "19 : Corrèze", corseDuSud = "2A : Corse-du-Sud", hauteCorse = "2B : Haute-Corse", coteDor = "21 : Côte-d’Or", cotesDarmor = "22 : Côtes-d’Armor", creuse = "23 : Creuse", dordogne = "24 : Dordogne", doubs = "25 : Doubs", drome = "26 : Drôme", eure = "27 : Eure", eureEtLoire = "28 : Eure-et-Loir", finistere = "29 : Finistère", gard = "30 : Gard", hauteGaronne = "31 : Haute-Garonne", gers = "32 : Gers", gironde = "33 : Gironde", herault = "34 : Hérault", ileEtVilaine = "35 : Ille-et-Vilaine", indre = "36 : Indre", indreEtLoire = "37 : Indre-et-Loire", isere = "38 : Isère", jura = "39 : Jura", landes = "40 : Landes", loireEtCher = "41 : Loir-et-Cher", loire = "42 : Loire", hauteLoire = "43 : Haute-Loire", loireAtlantique = "44 : Loire-Atlantique", loiret = "45 : Loiret", lot = "46 : Lot", lotEtGaronne = "47 : Lot-et-Garonne", lozere = "48 : Lozère", maineEtLoire = "49 : Maine-et-Loire", manche = "50 : Manche", marne = "51 : Marne", hauteMarne = "52 : Haute-Marne", mayenne = "53 : Mayenne", meurtheEtMozelle = "54 : Meurthe-et-Moselle", meuse = "55 : Meuse", morbihan = "56 : Morbihan", moselle = "57 : Moselle", nievre = "58 : Nièvre", nord = "59 : Nord", oise = "60 : Oise", orne = "61 : Orne", pasDeCalais = "62 : Pas-de-Calais", puyDeDome = "63 : Puy-de-Dôme", pyrennesAtlantiques = "64 : Pyrénées-Atlantiques", hautesPyrennes = "65 : Hautes-Pyrénées", pyrennesOrientales = "66 : Pyrénées-Orientales", basRhin = "67 : Bas-Rhin", hautRhin = "68 : Haut-Rhin", rhones = "69 : Rhône", hauteSaone = "70 : Haute-Saône", saoneEtLoire = "71 : Saône-et-Loire", sarthe = "72 : Sarthe", savoie = "73 : Savoie", hauteSavoie = "74 : Haute-Savoie", paris = "75 : Paris", seineMaritime = "76 : Seine-Maritime", seineEtMarne = "77 : Seine-et-Marne", yvelines = "78 : Yvelines", deuxSevres = "79 : Deux-Sèvres", somme = "80 : Somme", tarn = "81 : Tarn", tarnEtGaronne = "82 : Tarn-et-Garonne", vaR = "83 : Var", vaucluse = "84 : Vaucluse", vendee = "85 : Vendée", vienne = "86 : Vienne", hauteVienne = "87 : Haute-Vienne", vosges = "88 : Vosges", yonne = "89 : Yonne", territoireDeBelfort = "90 : Territoire de Belfort", essone = "91 : Essonne", hautDeSeine = "92 : Haut-de-Seine", seineSaintDenis = "93 : Seine-Saint-Senis", valDeMarne = "94 : Val-de-Marne", valDoise = "95 : Val-d’Oise", guadeloupe = "971 : Guadeloupe", martinique = "972 : Martinique", laReunion = "974 : La Réunion", nouvelleCaledonie = "Nouvelle-Calédonie", belgique = "Belgique"
}

struct FiltersItem {
    var type: MemberType?
    var department: String?
    var city: String?
}
