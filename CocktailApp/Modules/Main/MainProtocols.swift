//
//  MainViewProtocol.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showCocktails(_ items: [Cocktail])
    func showError(_ message: String)
    func updateFavoriteIDs(_ ids: [String])
    func showLoadingIndicator(_ show: Bool)
    
}

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol?            { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol?        { get set }
    func loadInitialData()
    func loadMoreCocktails()
    func didSelectItem(at indexPath: IndexPath)
    func toggleFavorite(_ cocktail: Cocktail)
    func loadFavoriteIDs()
}

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
    func fetchCocktails(letter: Character)
    func fetchFavoriteIDs()
    func updateFavorite(_ cocktail: Cocktail)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func cocktailsFetched(_ drinks: [Cocktail], for letter: Character)
    func cocktailsFetchFailed(_ error: String)
    func favoriteIDsFetched(_ ids: [String])
}

protocol MainRouterProtocol: AnyObject {
    static func createModule() -> UITabBarController
    func showDetail(from view: MainViewProtocol, with cocktail: Cocktail)
}
