//
//  DetailRouter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import UIKit

class DetailRouter: DetailRouterProtocol {
    static func createModule(with cocktail: Cocktail) -> UIViewController {
        let sb   = UIStoryboard(name: "Main", bundle: nil)
        let view = sb.instantiateViewController(identifier: "DetailVC") as! DetailViewController

        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()

        view.presenter        = presenter
        presenter.view        = view
        presenter.interactor  = interactor
        presenter.router      = router

        presenter.cocktail    = cocktail
        interactor.initialCocktail = cocktail

        interactor.presenter  = presenter
        return view
    }
}
