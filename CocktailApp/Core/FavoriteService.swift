//
//  FavoriteServiceProtocol.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import CoreData

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}

protocol FavoriteServiceProtocol {
    func isFavorite(id: String) -> Bool
    func toggleFavorite(_ cocktail: Cocktail)
    func fetchAll() -> [Cocktail]
}

class FavoriteService: FavoriteServiceProtocol {
    private let ctx = CoreDataStack.shared.context

    func isFavorite(id: String) -> Bool {
        let req: NSFetchRequest<Favorito> = Favorito.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id)
        let count = (try? ctx.count(for: req)) ?? 0
        return count > 0
    }

    func toggleFavorite(_ cocktail: Cocktail) {
        let req: NSFetchRequest<Favorito> = Favorito.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", cocktail.id)
        if let existing = (try? ctx.fetch(req))?.first {
            ctx.delete(existing)
        } else {
            let fav = Favorito(context: ctx)
            fav.id           = cocktail.id
            fav.name         = cocktail.name
            fav.category     = cocktail.category
            fav.thumbURL     = cocktail.thumbURL
        }
        CoreDataStack.shared.saveContext()
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }

    func fetchAll() -> [Cocktail] {
        let req: NSFetchRequest<Favorito> = Favorito.fetchRequest()
        let favs = (try? ctx.fetch(req)) ?? []
        var cocktails: [Cocktail] = []
        for f in favs {
            if let id = f.id, let name = f.name {
                let cocktail = Cocktail(
                    id:           id,
                    name:         name,
                    category:     f.category ?? "",
                    thumbURL:     f.thumbURL ?? "",
                    instructions: nil,
                    ingredients:  nil
                )
                cocktails.append(cocktail)
            }
        }
        return cocktails
    }
}
