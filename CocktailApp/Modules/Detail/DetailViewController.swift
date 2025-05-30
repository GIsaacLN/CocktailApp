//
//  DetailViewController.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 27/05/25.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var presenter: DetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        let favItem = UIBarButtonItem(
          image: UIImage(systemName: "heart"),
          style: .plain,
          target: self,
          action: #selector(toggleFavorite)
        )
        navigationItem.rightBarButtonItems = [favItem]

        enableSignOutButton()

        ingredientsListLabel.numberOfLines = 0
        instructionsLabel.numberOfLines = 0
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesDidChange),
            name: .favoritesUpdated,
            object: nil
        )
        presenter?.loadDetail()
    }

    @objc private func favoritesDidChange() {
        presenter?.loadDetail()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func toggleFavorite() {
        presenter?.toggleFavorite()
    }

    func showDetail(_ cocktail: Cocktail) {
        DispatchQueue.main.async {
            let cocktailID = cocktail.id
            self.title = cocktail.name
            self.categoryLabel.text = cocktail.category
            self.instructionsLabel.text = cocktail.instructions
            self.ingredientsListLabel.text = "• " + (cocktail.ingredients?.joined(separator: "\n• ") ?? "No tiene ingredientes")
            self.imageView.image = UIImage(systemName: "photo")
            
            let urlKey = cocktail.thumbURL as NSString

            if let cached = ImageCache.shared.object(forKey: urlKey) {
                self.imageView.image = cached
            } else {
                self.imageView.image = UIImage(systemName: "photo")
                URLSession.shared.dataTask(with: URL(string: cocktail.thumbURL)!) { data, _, _ in
                    guard let data = data, let img = UIImage(data: data) else { return }
                    ImageCache.shared.setObject(img, forKey: urlKey)
                    DispatchQueue.main.async {
                        if cocktailID == cocktail.id {
                            self.imageView.image = img
                        }
                    }
                }.resume()
            }
        }
    }

    func updateFavoriteState(isFav: Bool) {
        let sys = isFav ? "heart.fill" : "heart"
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems?[1].image = UIImage(systemName: sys)
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
