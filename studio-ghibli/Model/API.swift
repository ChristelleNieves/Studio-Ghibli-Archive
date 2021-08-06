//
//  API.swift
//  studio-ghibli
//
//  Created by Christelle Nieves on 8/5/21.
//

import Foundation

struct Film: Codable {
    var id: String
    var title: String
    var description: String
}

struct apiEndpoint {
    static var baseURL = "https://ghibliapi.herokuapp.com"
    static var allFilms = "/films"
}

public class API {
    
    func fetchAllFilms(completionHandler: @escaping ([Film]) -> Void) {
        guard let url = URL(string: apiEndpoint.baseURL + apiEndpoint.allFilms) else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            // Handle error
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            // Handle response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected error fetching data: \(response.debugDescription)")
                return
            }
            
            // Handle data
            if let data = data,
               let filmResponse = try? JSONDecoder().decode([Film].self, from: data) {
                completionHandler(filmResponse)
            }
        })
        
        // Resume task
        task.resume()
    }
}
