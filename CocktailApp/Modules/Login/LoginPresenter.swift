//
//  LoginPresenter.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?

    func login(username: String, password: String) {
        interactor?.validate(username: username, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginSucceeded() {
        router?.showMainModule()
    }
    func loginFailed(message: String) {
        view?.showError(message)
    }
}