//
//  ListCatConfigurator.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation

protocol ListCatConfiguratorProtocol: AnyObject {
    func configureListCatView(viewController: ListCatViewController)
}

class ListCatConfigurator: ListCatConfiguratorProtocol {
    func configureListCatView(viewController: ListCatViewController) {
        let router = ListCatRouter(evaluationView: viewController)
        let interactor = ListCatInteractor()
        let presenter = ListCatPresenter(withViewController: viewController, andRouter: router, useCase: interactor)
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        presenter.interactor?.presenter = presenter
        viewController.presenter = presenter
    }
}
