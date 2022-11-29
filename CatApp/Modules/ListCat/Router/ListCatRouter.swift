//
//  ListCatRouter.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation
import UIKit

protocol ListCatRouterProtocol: AnyObject {
    var currentViewController: ListCatViewController? {get set}
}

class ListCatRouter: ListCatRouterProtocol {
    weak var currentViewController: ListCatViewController?
    let storyBoardCat = UIStoryboard(name: Constants.Storyboards.catStoryboard, bundle: nil)
    
    init(evaluationView viewController: ListCatViewController) {
        self.currentViewController = viewController
    }
}
