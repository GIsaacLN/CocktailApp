//
//  CocktailCell.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import UIKit

protocol CocktailCellDelegate: AnyObject {
    /// El usuario pulsó el botón de favorito en esta celda
    func cocktailCell(_ cell: CocktailCell, didTapFavoriteFor cocktailID: String)
}

class CocktailCell: UITableViewCell {
    @IBOutlet var cocktailImageView: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var favButton: UIButton!
    private var cocktailID: String?
    weak var delegate: CocktailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }

    func configure(with cocktail: Cocktail, isFavorite: Bool) {
        cocktailID = cocktail.id
        titleView.text       = cocktail.name
        categoryLabel.text   = cocktail.category
        favButton.isSelected = isFavorite
        cocktailImageView.image = UIImage(systemName: "photo")
        
        // carga asíncrona de la imagen
        guard let url = URL(string: cocktail.thumbURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                // sólo la pongo si la celda sigue representando el mismo cóctel
                if self.cocktailID == cocktail.id {
                    self.cocktailImageView.image = img
                }
            }
        }.resume()
    }
    
    
    @IBAction func isFavoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        guard let id = cocktailID else { return }
        delegate?.cocktailCell(self, didTapFavoriteFor: id)
    }
}
