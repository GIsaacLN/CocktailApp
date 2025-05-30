//
//  UIViewController+SignOut.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 30/05/25.
//

import Foundation
import UIKit

import UIKit

extension UIViewController {
    func enableSignOutButton() {
        let signOut = UIBarButtonItem(
            title: "Salir",
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
        if var items = navigationItem.rightBarButtonItems {
            items.insert(signOut, at: 0)
            navigationItem.rightBarButtonItems = items
        } else {
            navigationItem.rightBarButtonItems = [signOut]
        }
    }
    
    @objc private func signOutTapped() {
        let alert = UIAlertController(
            title: "Aviso",
            message: "¿Deseas salir de la aplicación?",
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Cancelar", style: .cancel))
        alert.addAction(.init(title: "Aceptar", style: .destructive) { _ in exit(0) })
        present(alert, animated: true)
    }
}
