//
//  OMDbService.swift
//  Cinepolis
//
//  MODELO CONSUMO DE API
//

import Foundation

//MODELO API con campos JSON que devuelve la API
struct MovieDetail: Codable {
    let Title: String
    let Year: String
    let Genre: String
    let Director: String
    let Actors: String
    let Plot: String
    let Poster: String
}

class OMDbService {
    private let apiKey = "c0f6e2c8"  //clave de API de OMDb
    private let baseURL = "https://www.omdbapi.com/" //Es la URL base de la API de OMDb.
    
    //método se encarga de realizar la solicitud a la API y manejar la respuesta
    func fetchMovieDetail(title: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        //Crea la URL
        guard let url = URL(string: "\(baseURL)?apikey=\(apiKey)&t=\(title)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        //Realizar la solicitud
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //Manejar la respuesta
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 400, userInfo: nil)))
                return
            }
            
            do {
                //Decodificar los datos
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
            //Inicia la tarea
        }.resume()
    }
}
