//
//  ListCatPresenter.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation

protocol ListCatPresenterProtocol: AnyObject {
    func didShowListCat(listCat: [CatResponse])
    func getListCat()
}

class ListCatPresenter: ListCatPresenterProtocol {
    weak var view: ListCatViewProtocol?
    var router: ListCatRouterProtocol?
    var interactor: ListCatInteractorProtocol?
    
    init(withViewController view: ListCatViewProtocol?, andRouter router: ListCatRouterProtocol?, useCase interactor: ListCatInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func getListCat() {
        view?.showProgressView()
        interactor?.getListCat()
    }
    
    func didShowListCat(listCat: [CatResponse]) {
        view?.hideProgressView()
        view?.showListCat(cat: listCat)
    }
}
