//
//  LoginInteractor.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation
import CoreData

class LoginInteractor: LoginInteractorProtocol {
    private let context = CoreDataStack.shared.context
    weak var presenter: LoginInteractorOutputProtocol?
    
    func validate(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            presenter?.loginFailed(message: "campos vacíos")
            return
        }
        let pwBase64 = Data(password.utf8).base64EncodedString()
        let req: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        req.predicate = NSPredicate(format: "username == %@ AND password == %@", username, pwBase64)
        do {
            let found = try context.fetch(req)
            if !found.isEmpty {
                presenter?.loginSucceeded()
            } else {
                presenter?.loginFailed(message: "Usuario y contraseña incorrectos")
            }
        } catch {
            presenter?.loginFailed(message: "Error interno")
        }
    }
}
