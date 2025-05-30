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
    
    private let letters = Array("abcdefghijklmnopqrstuvwxyz")
    private var currentLetterIndex = 0
    private var isLoading = false
    private var allLoaded = false
    
    private var items: [Cocktail] = []
    
    func loadInitialData() {
        items.removeAll()
        currentLetterIndex = 0
        allLoaded = false
        view?.showLoadingIndicator(true)
        interactor?.fetchFavoriteIDs()
        interactor?.fetchCocktails(letter: letters[currentLetterIndex])
    }
    
    func loadMoreCocktails() {
        guard !isLoading, !allLoaded else { return }
        isLoading = true
        currentLetterIndex += 1
        guard currentLetterIndex < letters.count else {
            allLoaded = true
            return
        }
        interactor?.fetchCocktails(letter: letters[currentLetterIndex])
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let c = items[indexPath.row]
        router?.showDetail(from: view!, with: c)
    }
    
    func loadFavoriteIDs() {
        interactor?.fetchFavoriteIDs()
    }

    func toggleFavorite(_ cocktail: Cocktail) {
        interactor?.updateFavorite(cocktail)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func cocktailsFetched(_ drinks: [Cocktail], for letter: Character) {
        isLoading = false
        view?.showLoadingIndicator(false)
        
        if drinks.isEmpty {
            loadMoreCocktails()
            return
        }
        
        items.append(contentsOf: drinks)
        view?.showCocktails(items)
    }
    
    func cocktailsFetchFailed(_ error: String) {
        isLoading = false
        view?.showLoadingIndicator(false)
        view?.showError(error)
    }
    
    func favoriteIDsFetched(_ ids: [String]) {
        view?.updateFavoriteIDs(ids)
    }
}
