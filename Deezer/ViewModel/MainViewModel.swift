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
            updateLoadingStatus?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    func titleForHeaderInSection(at section: Int) -> String {
        return listGenre.count > 0 ? listGenre[section].name! : "Gênero"
    }
    
    func cellForItem(at indexPath: IndexPath) -> [Artist]? {
        if listGenre.indices.contains(indexPath.row) {
            return listGenre[indexPath.section].listArtists
        }
        return nil
    }
    
    func requestListGenre() {
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
    
    func requestListArtist(genre: Genre, index: Int) {
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
