//
//  MainPresenter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    private var items: [Cocktail] = []

    func loadCocktails() {
      interactor?.fetchCocktails()
    }

    func didSelectItem(at indexPath: IndexPath) {
      let cocktail = items[indexPath.row]
      router?.showDetail(from: view!, with: cocktail.id)
    }

    func loadFavoritesIDs() {
      interactor?.fetchFavoriteIDs()
    }

    func toggleFavorite(_ cocktail: Cocktail) {
      interactor?.updateFavorite(cocktail)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func cocktailsFetched(_ drinks: [Cocktail]) {
        items = drinks
        view?.showCocktails(drinks)
    }

    func cocktailsFetchFailed(_ error: String) {
        view?.showError(error)
    }
    
    func favoriteIDsFetched(_ ids: [String]) {
      view?.updateFavoriteIDs(ids)
    }
}
