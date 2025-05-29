//
//  LoginViewProtocol.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import UIKit

protocol LoginViewProtocol: AnyObject {
    func showError(_ message: String)
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    func login(username: String, password: String)
}

protocol LoginInteractorProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }
    func validate(username: String, password: String)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceeded()
    func loginFailed(message: String)
}

protocol LoginRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func showMainModule()
}
