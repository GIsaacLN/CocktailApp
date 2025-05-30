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
    private let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cócteles"
        tableView.tableFooterView = spinner
        enableSignOutButton()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesDidChange),
            name: .favoritesUpdated,
            object: nil
        )
        presenter?.loadInitialData()
    }
    
    @objc private func favoritesDidChange() {
        presenter?.loadFavoriteIDs()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showCocktails(_ items: [Cocktail]) {
        self.cocktails = items
        DispatchQueue.main.async { self.tableView.reloadData() }
    }

    func showError(_ message: String) {
        let a = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        a.addAction(.init(title: "OK", style: .default))
        present(a, animated: true)
    }

    func updateFavoriteIDs(_ ids: [String]) {
        favoriteIDs = Set(ids)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }

    func showLoadingIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            show ? self.spinner.startAnimating() : self.spinner.stopAnimating()
        }
    }
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }

    override func tableView(_ tv: UITableView, cellForRowAt ip: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "CocktailCell", for: ip) as! CocktailCell
        let c = cocktails[ip.row]
        cell.delegate = self
        cell.configure(with: c, isFavorite: favoriteIDs.contains(c.id))
        return cell
    }

    override func tableView(_ tv: UITableView, didSelectRowAt ip: IndexPath) {
        presenter?.didSelectItem(at: ip)
    }

    override func tableView(_ tv: UITableView, willDisplay cell: UITableViewCell, forRowAt ip: IndexPath) {
        if ip.row == cocktails.count - 1 {
            presenter?.loadMoreCocktails()
        }
    }
}

extension MainViewController: CocktailCellDelegate {
    func cocktailCell(_ cell: CocktailCell, didTapFavoriteFor cocktailID: String) {
        guard let c = cocktails.first(where: { $0.id == cocktailID }) else { return }
        presenter?.toggleFavorite(c)
    }
}
