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
        enableSignOutButton()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesDidChange),
            name: .favoritesUpdated,
            object: nil
        )
        presenter?.loadFavorites()
    }

    @objc private func favoritesDidChange() {
        presenter?.loadFavorites()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showFavorites(_ newItems: [Cocktail]) {
        let oldItems = items
        
        let oldIDs = oldItems.map { $0.id }
        let newIDs = newItems.map { $0.id }
        
        var deletes: [IndexPath] = []
        for (idx, id) in oldIDs.enumerated() where !newIDs.contains(id) {
            deletes.append(IndexPath(row: idx, section: 0))
        }
        
        var inserts: [IndexPath] = []
        for (idx, id) in newIDs.enumerated() where !oldIDs.contains(id) {
            inserts.append(IndexPath(row: idx, section: 0))
        }
        
        items = newItems
        
        tableView.beginUpdates()
        tableView.deleteRows(at: deletes,   with: .automatic)
        tableView.insertRows(at: inserts,   with: .automatic)
        tableView.endUpdates()
        
        updateBackgroundView()
    }

    private func updateBackgroundView() {
        if items.isEmpty {
            let lbl = UILabel()
            lbl.text = "Aún no tienes favoritos.\nAgrega algunos desde la sección de cócteles."
            lbl.textColor = .gray
            lbl.numberOfLines = 0
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            lbl.translatesAutoresizingMaskIntoConstraints = false

            let bg = UIView(frame: tableView.bounds)
            bg.addSubview(lbl)
            NSLayoutConstraint.activate([
                lbl.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
                lbl.centerYAnchor.constraint(equalTo: bg.centerYAnchor),
                lbl.leadingAnchor.constraint(greaterThanOrEqualTo: bg.leadingAnchor, constant: 20),
                lbl.trailingAnchor.constraint(lessThanOrEqualTo: bg.trailingAnchor, constant: -20),
            ])

            tableView.backgroundView = bg
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
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
        presenter?.toggleFavorite(cocktail)
    }
}
