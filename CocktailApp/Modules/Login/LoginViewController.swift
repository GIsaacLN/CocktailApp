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

    private var originalUsernamePlaceholder: String?
    private var originalPasswordPlaceholder: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        enableSignOutButton()
        
        originalUsernamePlaceholder = usernameTextField.placeholder
        originalPasswordPlaceholder = passwordTextField.placeholder

        [usernameTextField, passwordTextField].forEach {
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 0
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        clearFieldStyles()
        presenter?.login(
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    func showError(_ message: String) {
        if message == "campos vacíos" {
            highlightEmptyFields()
        } else {
            let a = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "OK", style: .default))
            present(a, animated: true)
        }
    }

    private func clearFieldStyles() {
        for tf in [usernameTextField, passwordTextField] {
            tf?.layer.borderWidth = 0
            tf?.attributedPlaceholder = nil
        }
        usernameTextField.placeholder = originalUsernamePlaceholder
        passwordTextField.placeholder = originalPasswordPlaceholder
    }

    private func highlightEmptyFields() {
        let fields: [(UITextField, String?)] = [
            (usernameTextField, originalUsernamePlaceholder),
            (passwordTextField, originalPasswordPlaceholder)
        ]
        for (tf, original) in fields {
            if tf.text?.isEmpty ?? true {
                tf.layer.borderColor = UIColor.red.cgColor
                tf.layer.borderWidth = 1
                tf.attributedPlaceholder = NSAttributedString(
                    string: "campos vacíos",
                    attributes: [.foregroundColor: UIColor.red]
                )
            }
        }
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
