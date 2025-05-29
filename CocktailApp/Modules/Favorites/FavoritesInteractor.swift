//
//  FavoritesInteractor.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class FavoritesInteractor: FavoritesInteractorProtocol {
    weak var presenter: FavoritesInteractorOutputProtocol?
    private let favService = FavoriteService()

    func fetchFavorites() {
        let favs = favService.fetchAll()
        presenter?.favoritesFetched(favs)
    }

    func updateFavorite(_ cocktail: Cocktail) {
        favService.toggleFavorite(cocktail)
        fetchFavorites()
    }
}
