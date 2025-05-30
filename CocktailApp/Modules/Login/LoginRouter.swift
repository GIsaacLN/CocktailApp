//
//  LoginRouter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import UIKit

class LoginRouter: LoginRouterProtocol {
    weak var view: LoginViewProtocol?

    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "LoginVC") as! LoginViewController
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view

        return view
    }

    func showMainModule() {
        guard
          let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let delegate = scene.delegate as? SceneDelegate,
          let window = delegate.window
        else { return }

        let mainTab = MainRouter.createModule()

        window.rootViewController = mainTab
        window.makeKeyAndVisible()
    }
}
