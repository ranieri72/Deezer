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
    
    func requestListArtist(artist: Artist,
                           onStart: () -> Void,
                           onError: @escaping (String) -> Void,
                           onSuccess: @escaping ([Artist]) -> Void) {
        let url = String(format: "https://api.deezer.com/artist/%d/related", artist.id!)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listArtist = [Artist]()
                            print(String(format: "Request listRelatedArtist: %d - artist: %@", jsonArray.count, artist.name!))
                            
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
    
    func requestListArtist(artistSearched: String,
                           onStart: () -> Void,
                           onError: @escaping (String) -> Void,
                           onSuccess: @escaping ([Artist]) -> Void) {
        let newString = artistSearched.replacingOccurrences(of: " ", with: "%20")
        
        let url = String(format: "https://api.deezer.com/search/artist?q=%@", newString)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listArtist = [Artist]()
                            print(String(format: "Request requestListArtist: %d - artistSearched: %@", jsonArray.count, artistSearched))
                            
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
    
    func requestListAlbum(artist: Artist,
                           onStart: () -> Void,
                           onError: @escaping (String) -> Void,
                           onSuccess: @escaping ([Album]) -> Void) {
        let url = String(format: "https://api.deezer.com/artist/%d/albums", artist.id!)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listAlbum = [Album]()
                            print(String(format: "Request listAlbum: %d - artist: %@", jsonArray.count, artist.name!))
                            
                            for album in jsonArray{
                                listAlbum.append(Album(album))
                            }
                            onSuccess(listAlbum)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
    
    func requestRadio(artist: Artist,
                          onStart: () -> Void,
                          onError: @escaping (String) -> Void,
                          onSuccess: @escaping ([Music]) -> Void) {
        let url = String(format: "https://api.deezer.com/artist/%d/radio", artist.id!)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listMusic = [Music]()
                            print(String(format: "Request listMusic: %d - artist: %@", jsonArray.count, artist.name!))
                            
                            for music in jsonArray {
                                listMusic.append(Music(music))
                            }
                            onSuccess(listMusic)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
    
    func requestListMusic(artist: Artist,
                          onStart: () -> Void,
                          onError: @escaping (String) -> Void,
                          onSuccess: @escaping ([Music]) -> Void) {
        let url = String(format: "https://api.deezer.com/artist/%d/top?limit=%d", artist.id!, 25)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listMusic = [Music]()
                            print(String(format: "Request listMusic: %d - artist: %@", jsonArray.count, artist.name!))
                            
                            for music in jsonArray {
                                listMusic.append(Music(music))
                            }
                            onSuccess(listMusic)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
    
    func requestListMusic(album: Album,
                          onStart: () -> Void,
                          onError: @escaping (String) -> Void,
                          onSuccess: @escaping ([Music]) -> Void) {
        let url = String(format: "https://api.deezer.com/album/%d/tracks", album.id!)
        onStart();
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Any] {
                        
                        if let jsonArray = data["data"] as? [[String : Any]] {
                            var listMusic = [Music]()
                            print(String(format: "Request listMusic: %d - album: %@", jsonArray.count, album.title!))
                            
                            for music in jsonArray {
                                listMusic.append(Music(music))
                            }
                            onSuccess(listMusic)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    onError(error.localizedDescription);
                }
        }
    }
}
