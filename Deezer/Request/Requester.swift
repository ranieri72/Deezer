//
//  Requester.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 08/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import Alamofire

class Requester {
    
    func requestListGenre(onStart: () -> Void,
                          onError: @escaping (String) -> Void,
                          onSuccess: @escaping ([Genre]) -> Void) {
        let url = "https://api.deezer.com/genre"
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listGenre = [Genre]()
                            print(String(format: "Request listGenre: %d", jsonArray.count))
                            
                            for genre in jsonArray{
                                listGenre.append(Genre(genre))
                            }
                            onSuccess(listGenre)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
    
    func requestListArtist(genre: Genre,
                           onStart: () -> Void,
                           onError: @escaping (String) -> Void,
                           onSuccess: @escaping ([Artist]) -> Void) {
        let url = String(format: "https://api.deezer.com/genre/%d/artists", genre.id!)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listArtist = [Artist]()
                            print(String(format: "Request listArtist: %d - genre: %@", jsonArray.count, genre.name!))
                            
                            for artist in jsonArray{
                                listArtist.append(Artist(artist))
                            }
                            onSuccess(listArtist)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
}
