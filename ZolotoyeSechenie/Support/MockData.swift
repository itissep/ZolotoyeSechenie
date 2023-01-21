//
//  MockData.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit

// or json from server?

struct MockData {
    struct CareProgramms {
        let id: String
        let title: String
        let image: UIImage?
        
        static let all = [
            CareProgramms(id: "first", title: "First Category", image: UIImage(named: "1")),
            CareProgramms(id: "second", title: "second Category", image: UIImage(named: "2")),
            CareProgramms(id: "third", title: "third Category", image: UIImage(named: "3")),
            CareProgramms(id: "forth", title: "forth Category", image: UIImage(named: "4")),
            CareProgramms(id: "fifth", title: "fifth Category", image: UIImage(named: "5")),
        ]
    }

    struct DecorativeCategories {
        let id: String
        let image: UIImage?
        
        static let all = [
            DecorativeCategories(id: "first", image: UIImage(named: "1")),
            DecorativeCategories(id: "second", image: UIImage(named: "2")),
            DecorativeCategories(id: "third", image: UIImage(named: "3")),
            DecorativeCategories(id: "forth", image: UIImage(named: "4")),
            DecorativeCategories(id: "fifth", image: UIImage(named: "5")),
            DecorativeCategories(id: "sixth", image: UIImage(named: "6")),
            DecorativeCategories(id: "seventh", image: UIImage(named: "7")),
        ]
    }


    struct SpecialProducts {
        let id: String
        let title: String
        let image: UIImage?
        
        static let all = [
            SpecialProducts(id: "first", title: "First Category", image: UIImage(named: "1")),
            SpecialProducts(id: "second", title: "second Category", image: UIImage(named: "2")),
            SpecialProducts(id: "third", title: "third Category", image: UIImage(named: "3")),
            SpecialProducts(id: "forth", title: "forth Category", image: UIImage(named: "4")),
            SpecialProducts(id: "fifth", title: "fifth Category", image: UIImage(named: "5")),
        ]
    }
}



