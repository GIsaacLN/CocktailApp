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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"), style: .plain,
            target: self, action: #selector(toggleFavorite)
        )
        ingredientsListLabel.numberOfLines = 0
        instructionsLabel.numberOfLines = 0
        presenter?.loadDetail()
    }

    @objc func toggleFavorite() {
        presenter?.toggleFavorite()
    }

    func showDetail(_ cocktail: Cocktail) {
        let cocktailID = cocktail.id
        DispatchQueue.main.async {
            self.title = cocktail.name
            self.categoryLabel.text = cocktail.category
            self.instructionsLabel.text = cocktail.instructions
            self.ingredientsListLabel.text = "• " + (cocktail.ingredients?.joined(separator: "\n• ") ?? "No tiene ingredientes")
            self.imageView.image = UIImage(systemName: "photo") // placeholder
            
            // carga asíncrona de la imagen
            guard let url = URL(string: cocktail.thumbURL) else { return }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let img = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    // sólo la pongo si la celda sigue representando el mismo cóctel
                    if cocktailID == cocktail.id {
                        self.imageView.image = img
                    }
                }
            }.resume()
        }
    }

    func updateFavoriteState(isFav: Bool) {
        let sys = isFav ? "heart.fill" : "heart"
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: sys)
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
