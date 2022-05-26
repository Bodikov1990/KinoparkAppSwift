//
//  NetworkManager.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static var shared = NetworkManager()
    
    let startingUrl = "http://afisha.api.kinopark.kz/api/city"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzcC5raW5vcGFyayIsInN1YiI6ImZyb250LnByb2QiLCJuYW1lIjoiYWZpc2hhLWFwaS5wcm9kIn0.IBScyJ7iIRrxh6nqLMCwHz1z4P0r0Epmsf6hA2abEjU"
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetchWithBearerToken<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "OPTIONS"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("Asia/Almaty", forHTTPHeaderField: "TimeZone")
        request.addValue("ru-RU", forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
//            Вывод на консоль, для проверки получил ли вообще data
//            print("DATA" + String(data: data, encoding: .utf8)!)
//            Decoding data
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }

                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }

}
