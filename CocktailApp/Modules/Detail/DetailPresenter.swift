//
//  DetailPresenter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    var cocktail: Cocktail?

    func loadDetail() {
        guard let c = cocktail else { return }
        interactor?.fetchDetail(id: c.id)
    }

    func toggleFavorite() {
        guard let c = cocktail else { return }
        interactor?.updateFavorite(c)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func detailFetched(_ d: Cocktail, isFavorite: Bool) {
        view?.showDetail(d)
        view?.updateFavoriteState(isFav: isFavorite)
    }

    func detailFetchFailed(_ error: String) {
        // TODO: - Error de fetch failed
    }
}
