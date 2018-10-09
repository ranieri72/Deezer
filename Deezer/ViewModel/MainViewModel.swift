//
//  MainViewModel.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 09/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import Foundation

class MainViewModel {
    
    private var listGenre: [Genre] = [Genre]()
    
    var numberOfSections: Int {
        return listGenre.count > 0 ? listGenre.count : 10
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    func getNameOfSection( at section: Int ) -> String {
        return listGenre.count > 0 ? listGenre[section].name! : "Gênero"
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> [Artist]? {
        if listGenre.count > 0 {
            if let listArtists = listGenre[indexPath.section].listArtists {
                return listArtists
            }
        }
        return nil
    }
    
    func requestListGenre(){
        Requester().requestListGenre(
            onStart: { () in
                isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listGenre in
            self.listGenre = listGenre
            for (index, genre) in listGenre.enumerated() {
                self.requestListArtist(genre: genre, index: index)
            }
        }
        )
    }
    
    func requestListArtist(genre: Genre, index: Int){
        Requester().requestListArtist(
            genre: genre,
            onStart: { () in
                isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listArtist in
            self.listGenre[index].listArtists = listArtist
            self.reloadTableViewClosure?()
            self.isLoading = false
        }
        )
    }
}
