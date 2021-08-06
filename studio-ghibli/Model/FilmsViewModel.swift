//
//  FilmsViewModel.swift
//  studio-ghibli
//
//  Created by Christelle Nieves on 8/5/21.
//

import Foundation

public class FilmsViewModel {
    
    let shared = API()
    var films = [Film]()
    
    func getAllFilmsFromAPI(completionHander: @escaping () -> Void) {
        shared.fetchAllFilms(completionHandler: { response in
            self.films = response
            
            DispatchQueue.main.async {
                completionHander()
            }
        })
    }
}
