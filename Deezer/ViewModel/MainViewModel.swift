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
    private var listSearchedArtist = [Artist]()
    private var timer = Timer()
    private var stringArtist = ""
    
    var numberOfSections: Int {
        return listGenre.count > 0 ? listGenre.count : 10
    }
    
    var numberOfRowsSearchTable: Int {
        return listSearchedArtist.count
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    var reloadGenreTableViewClosure: (()->())?
    var reloadSearchTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    func titleForHeaderInSection(at section: Int) -> String {
        return listGenre.count > 0 ? listGenre[section].name! : "Gênero"
    }
    
    func cellForListArtist(at indexPath: IndexPath) -> [Artist]? {
        if listGenre.indices.contains(indexPath.row) {
            return listGenre[indexPath.section].listArtists
        }
        return nil
    }
    
    func cellForSearchArtist(at indexPath: IndexPath) -> Artist? {
        if listSearchedArtist.indices.contains(indexPath.row) {
            return listSearchedArtist[indexPath.section]
        }
        return nil
    }
    
    func searchTextDidChange(searchText: String) {
        if searchText.count > 1 {
            stringArtist = searchText
            restartTimer()
        }
    }
    
    func restartTimer(){
        timer.invalidate();
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(self.requestListSearchedArtist),
                                     userInfo: nil,
                                     repeats: false)
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
            self.reloadGenreTableViewClosure!()
            self.isLoading = false
        }
        )
    }
    
    @objc func requestListSearchedArtist() {
        Requester().requestListArtist(
            artistSearched: stringArtist,
            onStart: { () in
                self.isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listArtist in
            self.listSearchedArtist = listArtist
            self.reloadSearchTableViewClosure!()
            self.isLoading = false
        }
        )
    }
}
