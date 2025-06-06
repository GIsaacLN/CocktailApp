//
//  FavoritesRouter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import UIKit

class FavoritesRouter: FavoritesRouterProtocol {
    weak var view: FavoritesViewProtocol?

    func showDetail(from view: FavoritesViewProtocol, with cocktail: Cocktail) {
        guard let vc = view as? UIViewController else { return }
        let detailVC = DetailRouter.createModule(with: cocktail)
        vc.navigationController?.pushViewController(detailVC, animated: true)
    }
}
