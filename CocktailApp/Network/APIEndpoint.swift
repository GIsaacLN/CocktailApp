//
//  APIEndpoint.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    case search(letter: Character)
    case lookup(id: String)

    var url: URL {
        switch self {
        case .search(let letter):
            return URL(string: "\(APIEndpoint.baseURL)search.php?f=\(letter)")!
        case .lookup(let id):
            return URL(string: "\(APIEndpoint.baseURL)lookup.php?i=\(id)")!
        }
    }
}
