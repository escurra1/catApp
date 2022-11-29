//
//  ListCatInteractor.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation
import Alamofire

protocol ListCatInteractorProtocol: AnyObject {
    func getListCat()
    var presenter: ListCatPresenterProtocol? { get set }
}

class ListCatInteractor: ListCatInteractorProtocol {
    weak var presenter: ListCatPresenterProtocol?
    func getListCat() {
        guard let url = URL(string: Constants.Urls.baseUrl) else {
            return
        }
        let request = AF.request(url,
                                 method: .get,
                                 parameters: nil,
                                 encoding: JSONEncoding.default, headers: HeaderAPI.headers())
        let decodableResponse = [CatResponse].self
        request.responseDecodable(of: decodableResponse) { response in
            switch response.result {
            case .success(let response):
                self.presenter?.didShowListCat(listCat: response)
                print("Response: \(response)")
                break
            case .failure(let error):
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
}
