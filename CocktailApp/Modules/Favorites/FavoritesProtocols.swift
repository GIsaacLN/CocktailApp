//
//  FavoritesViewProtocol.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ items: [Cocktail])
}

protocol FavoritesPresenterProtocol: AnyObject {
    var view: FavoritesViewProtocol? { get set }
    var interactor: FavoritesInteractorProtocol? { get set }
    var router: FavoritesRouterProtocol? { get set }
    func loadFavorites()
    func didSelectItem(at indexPath: IndexPath)
    func toggleFavorite(_ cocktail: Cocktail)
}

protocol FavoritesInteractorProtocol: AnyObject {
    var presenter: FavoritesInteractorOutputProtocol? { get set }
    func fetchFavorites()
    func updateFavorite(_ cocktail: Cocktail)
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func favoritesFetched(_ items: [Cocktail])
}

protocol FavoritesRouterProtocol: AnyObject {
    func showDetail(from view: FavoritesViewProtocol, with id: String)
}
