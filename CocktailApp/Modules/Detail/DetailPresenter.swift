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
    var cocktailID: String?
    private var detail: Cocktail?

    func loadDetail() {
        guard let id = cocktailID else { return }
        interactor?.fetchDetail(id: id)
    }

    func toggleFavorite() {
        guard let d = detail else { return }
        interactor?.updateFavorite(d)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func detailFetched(_ d: Cocktail, isFavorite: Bool) {
        detail = d
        view?.showDetail(d)
        view?.updateFavoriteState(isFav: isFavorite)
    }

    func detailFetchFailed(_ error: String) {
        // manejar error
    }
}
