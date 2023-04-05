//
//  Constants.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 19.01.2023.
//

import UIKit

class K {
    static let hPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 12
    
    class Fonts {
        static let regular11 = UIFont.systemFont(ofSize: 11 , weight: .regular)
        static let regular13 = UIFont.systemFont(ofSize: 13 , weight: .regular)
        static let regular15 = UIFont.systemFont(ofSize: 15 , weight: .regular)
        static let regular17 = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        static let semibold11 = UIFont.systemFont(ofSize: 11, weight: .semibold) //authorFont
        static let semibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold) //authorFont
        static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold) //authorFont
        static let semibold20 = UIFont.systemFont(ofSize: 20, weight: .semibold) //  pictureTitleFont
        static let semibold30 = UIFont.systemFont(ofSize: 30, weight: .semibold) //  name on profile screen
        
        static let bold24 = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let bold30 = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        static let medium20 = UIFont.systemFont(ofSize: 20, weight: .medium)
        static let medium17 = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    class Colors {
        static let gold = UIColor(named: "gold")!
        static let darkGold = UIColor(named: "darkGold")!
        static let prettyGold = UIColor(named: "prettyGold")!
        
        static let gray = UIColor(named: "Aviator Gray")!
        static let brown = UIColor(named: "Brown River")!
        static let lightRed = UIColor(named: "Light Red Wine")!
        static let darkRed = UIColor(named: "Red Wine")!
        static let middleRed = UIColor(named: "Medium Red Wine")!
        static let pink = UIColor(named: "Smoked Pink")!
        static let white = UIColor(named: "Whitish")!
        static let dirtyWhite = UIColor(named: "Smoked White")!
        static let black = UIColor(named: "Blackish")!
    }
    
    class Icons {
        
        static let house = UIImage(named: "house")!
        static let houseFill = UIImage(named: "houseFill")!
        
        static let bell = UIImage(named: "bell")!
        static let bellFill = UIImage(named: "bellFill")!
        
        static let magnifyingglass = UIImage(named: "magnifyingglass")!
        static let magnifyingglassFill = UIImage(named: "magnifyingglassFill")!
        
        static let person = UIImage(named: "person")!
        static let personFill = UIImage(named: "personFill")!
        
        static let cart = UIImage(named: "cartOnGold")!
        
        static let disclosureIndicator = UIImage(named: "Disclosure Indicator")!
        
        class Settings {
            static let payments = UIImage(named: "creditcard.fill")!
            static let history = UIImage(named: "shippingbox.fill")!
            static let delete = UIImage(named: "trash.fill")!
            static let signOut = UIImage(named: "rectangle.portrait.and.arrow.right.fill")!
            static let addresses = UIImage(named: "house.fill")!
        }
        
    }
    
    class Images {
        static let logo = UIImage(named: "logo")!
    }
    
    class Unspecified {
        static let titleAttributes = [NSAttributedString.Key.foregroundColor: K.Colors.darkGold]
    }
    
}
