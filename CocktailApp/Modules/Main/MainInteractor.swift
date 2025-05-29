//
//  MainInteractor.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    private let api        = NetworkManager.shared
    private let favService = FavoriteService()

    func fetchCocktails() {
        api.request(endpoint: .search(letter: "a")) { (res: Result<APIResponse<Cocktail>, Error>) in
            switch res {
            case .success(let resp):
                let list = resp.drinks ?? []
                self.presenter?.cocktailsFetched(list)
            case .failure:
                self.presenter?.cocktailsFetchFailed("Error cargando cócteles.")
            }
        }
    }

    func fetchFavoriteIDs() {
        let favs = favService.fetchAll()
        let ids  = favs.map { $0.id }
        presenter?.favoriteIDsFetched(ids)
    }

    func updateFavorite(_ cocktail: Cocktail) {
        favService.toggleFavorite(cocktail)
        fetchFavoriteIDs()
    }
}
