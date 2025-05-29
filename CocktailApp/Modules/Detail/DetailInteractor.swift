//
//  DetailInteractor.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailInteractorOutputProtocol?
    private let api        = NetworkManager.shared
    private let favService = FavoriteService()

    func fetchDetail(id: String) {
        api.request(endpoint: .lookup(id: id)) { (res: Result<APIResponse<Cocktail>, Error>) in
            switch res {
            case .success(let resp):
                guard let cocktail = resp.drinks?.first else {
                    self.presenter?.detailFetchFailed("Detalle no encontrado.")
                    return
                }
                let isFav = self.favService.isFavorite(id: cocktail.id)
                self.presenter?.detailFetched(cocktail, isFavorite: isFav)

            case .failure:
                self.presenter?.detailFetchFailed("Error cargando detalle.")
            }
        }
    }

    func updateFavorite(_ cocktail: Cocktail) {
        favService.toggleFavorite(cocktail)
        let isFav = favService.isFavorite(id: cocktail.id)
        presenter?.detailFetched(cocktail, isFavorite: isFav)
    }
}
