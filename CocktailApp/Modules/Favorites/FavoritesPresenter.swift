//
//  FavoritesPresenter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {
    weak var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    private var items: [Cocktail] = []

    func loadFavorites() {
        interactor?.fetchFavorites()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let fav = items[indexPath.row]
        router?.showDetail(from: view!, with: fav)
    }
    
    func toggleFavorite(_ cocktail: Cocktail) {
      interactor?.updateFavorite(cocktail)
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func favoritesFetched(_ favs: [Cocktail]) {
        items = favs
        view?.showFavorites(favs)
    }
}
