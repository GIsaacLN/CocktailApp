//
//  LoginViewController.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 27/05/25.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Salir", style: .plain,
            target: self, action: #selector(signOut)
        )
    }

    @objc func signOut() {
        let alert = UIAlertController(title: "Aviso", message: "Deseas salir de la aplicación", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive) { _ in exit(0) })
        present(alert, animated: true)
    }

    func showError(_ message: String) {
        let a = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        presenter?.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
