//
//  MainRouter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import UIKit

class MainRouter: MainRouterProtocol {    
    weak var view: MainViewProtocol?
    
    static func createModule() -> UITabBarController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = sb.instantiateViewController(
            identifier: "MainTabBarController"
        ) as! UITabBarController
        
        guard let tabs = tabBar.viewControllers as? [UINavigationController] else {
            return tabBar
        }
        
        let cocktailsNav = tabs[0]
        if let cocktailsVC = cocktailsNav.viewControllers.first as? MainViewController {
            let presenter = MainPresenter()
            let interactor = MainInteractor()
            let router    = MainRouter()
            
            cocktailsVC.presenter    = presenter
            presenter.view           = cocktailsVC
            presenter.interactor     = interactor
            presenter.router         = router
            interactor.presenter     = presenter
            router.view              = cocktailsVC
        }
        
        let favsNav  = tabs[1]
        if let favsVC = favsNav.viewControllers.first as? FavoritesViewController {
            let presenter = FavoritesPresenter()
            let interactor = FavoritesInteractor()
            let router    = FavoritesRouter()
            
            favsVC.presenter    = presenter
            presenter.view      = favsVC
            presenter.interactor = interactor
            presenter.router    = router
            interactor.presenter = presenter
            router.view          = favsVC
        }
        
        return tabBar
    }
    
    func showDetail(from view: MainViewProtocol, with cocktail: Cocktail) {
        guard let vc = view as? UIViewController else { return }
        let detailVC = DetailRouter.createModule(with: cocktail)
        vc.navigationController?.pushViewController(detailVC, animated: true)
    }
}
