//
//  MainViewController.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 27/05/25.
//

import UIKit

class MainViewController: UITableViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    
    private var cocktails: [Cocktail] = []
    private var favoriteIDs = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cócteles"
        // 2) carga primero los favoritos guardados y luego los cócteles
        presenter?.loadFavoritesIDs()
        presenter?.loadCocktails()
    }
    
    func showCocktails(_ items: [Cocktail]) {
        cocktails = items
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func showError(_ message: String) {
        let a = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
    
    func updateFavoriteIDs(_ ids: [String]) {
        favoriteIDs = Set(ids)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    // MARK: - Table
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }
    
    override func tableView(_ tv: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tv.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as? CocktailCell else {
            fatalError("Couldn't deque to CocktailCell")
        }
        let cocktail = cocktails[indexPath.row]

        cell.delegate = self
        let isFav = favoriteIDs.contains(cocktail.id)
        cell.configure(with: cocktail, isFavorite: isFav)
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

extension MainViewController: CocktailCellDelegate {
    func cocktailCell(_ cell: CocktailCell, didTapFavoriteFor cocktailID: String) {
        // 1) Buscamos el Cocktail en nuestro array
        guard let cocktail = cocktails.first(where: { $0.id == cocktailID }) else { return }
        // 2) Le pedimos al Presenter que togglee ese Cocktail
        presenter?.toggleFavorite(cocktail)
    }
}
