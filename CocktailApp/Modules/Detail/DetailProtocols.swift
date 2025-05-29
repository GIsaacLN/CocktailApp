//
//  DetailViewProtocol.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import UIKit


protocol DetailViewProtocol: AnyObject {
    func showDetail(_ cocktail: Cocktail)
    func updateFavoriteState(isFav: Bool)
}

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    var cocktailID: String? { get set }
    func loadDetail()
    func toggleFavorite()
}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    func fetchDetail(id: String)
    func updateFavorite(_ cocktail: Cocktail)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func detailFetched(_ detail: Cocktail, isFavorite: Bool)
    func detailFetchFailed(_ error: String)
}

protocol DetailRouterProtocol: AnyObject {
    static func createModule(cocktailID: String) -> UIViewController
}
