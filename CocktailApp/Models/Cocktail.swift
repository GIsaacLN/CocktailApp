//
//  Cocktail.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let drinks: [T]?
}

struct Cocktail: Codable {
    let id: String
    let name: String
    let category: String
    let thumbURL: String
    let instructions: String?
    let ingredients: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id           = "idDrink"
        case name         = "strDrink"
        case category     = "strCategory"
        case thumbURL     = "strDrinkThumb"
        case instructions = "strInstructions"
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id           = try c.decode(String.self, forKey: .id)
        name         = try c.decode(String.self, forKey: .name)
        category     = try c.decode(String.self, forKey: .category)
        thumbURL     = try c.decode(String.self, forKey: .thumbURL)
        instructions = try c.decodeIfPresent(String.self, forKey: .instructions)
        
        let raw = try decoder.container(keyedBy: DynamicKey.self)
        var ingr: [String] = []
        for i in 1...15 {
            guard let key = DynamicKey(stringValue: "strIngredient\(i)"),
                  let v = try raw.decodeIfPresent(String.self, forKey: key),
                  !v.trimmingCharacters(in: .whitespaces).isEmpty
            else { continue }
            ingr.append(v)
        }
        ingredients = ingr.isEmpty ? nil : ingr
    }
}

typealias CocktailModel = Cocktail
extension CocktailModel {
    init(id: String, name: String, category: String, thumbURL: String, instructions: String? = nil, ingredients: [String]? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.thumbURL = thumbURL
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

private struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
}
