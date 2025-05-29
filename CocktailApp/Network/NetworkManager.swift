//
//  NetworkManager.swift
//  CocktailApp
//
//  Created by Gustavo Isaac Lopez Nunez on 28/05/25.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        print("Iniciando petición a URL:", endpoint.url)

        URLSession.shared.dataTask(with: endpoint.url) { data, response, error in
            if let e = error {
                print("Error en la petición:", e.localizedDescription)
                return completion(.failure(e))
            }

            if let httpResp = response as? HTTPURLResponse {
                print("Código de respuesta HTTP:", httpResp.statusCode)
            }

            guard let d = data else {
                let noDataError = NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió data"])
                print("No llegó data")
                return completion(.failure(noDataError))
            }
            print("Data recibida (\(d.count) bytes)")

            do {
                let decoded = try JSONDecoder().decode(T.self, from: d)
                print("Decodificación exitosa:", decoded)
                completion(.success(decoded))
            } catch {
                print("Error decodificando:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
