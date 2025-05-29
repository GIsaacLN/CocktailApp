//
//  FavoritesViewController.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 27/05/25.
//

import UIKit


class FavoritesViewController: UITableViewController, FavoritesViewProtocol {
    
    var presenter: FavoritesPresenterProtocol?
    private var items: [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoritos"
        presenter?.loadFavorites()
    }
    
    @objc func signOut() {
        let alert = UIAlertController(title: "Aviso", message: "Deseas salir de la aplicación", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive) { _ in exit(0) })
        present(alert, animated: true)
    }
    
    func showFavorites(_ items: [Cocktail]) {
        self.items = items
        tableView.reloadData()
    }
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as? CocktailCell else {
            fatalError("Couldn't deque to CocktailCell")
        }
        let cocktail = items[indexPath.row]

        cell.delegate = self
        cell.configure(with: cocktail, isFavorite: true)
        return cell
    }
    
    
    override func tableView(_ tv: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
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

extension FavoritesViewController: CocktailCellDelegate {
    func cocktailCell(_ cell: CocktailCell, didTapFavoriteFor cocktailID: String) {
        guard let cocktail = items.first(where: { $0.id == cocktailID }) else { return }
        // 2) Le pedimos al Presenter que togglee ese Cocktail
        presenter?.toggleFavorite(cocktail)
    }
}
