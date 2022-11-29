//
//  Constants.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let baseUrl = "https://api.thecatapi.com/v1/breeds"
    }
    
    struct ViewControllers {
        static let listMovieViewController = "ListCatViewController"
    }
    
    struct Storyboards {
        static let catStoryboard = "Cat"
    }
    
    struct Cells {
        static let listCatTableViewCell = "ListCatTableViewCell"
        static let rowHeightCatListCell: CGFloat = 240.0
    }
}
