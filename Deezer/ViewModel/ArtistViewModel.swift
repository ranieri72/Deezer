//
//  ArtistViewModel.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 11/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class ArtistViewModel {
    
    let topImage = 0
    let albumImages = 1
    let relatedImages = 2
    
    private var listAlbum = [Album]()
    private var listRelated = [Artist]()
    
    var numberOfItemsInListAlbum: Int {
        return listAlbum.count > 0 ? listAlbum.count : 10
    }
    
    var numberOfItemsInListRelated: Int {
        return listRelated.count > 0 ? listRelated.count : 10
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    var artistImage: UIImage? {
        didSet {
            updateArtistImage?()
        }
    }
    
    var pushView: UIViewController? {
        didSet {
            pushToView?()
        }
    }
    
    var reloadAlbumsCollectionViewClosure: (()->())?
    var reloadRelatedCollectionViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var updateArtistImage: (()->())?
    var pushToView: (()->())?
    
    func didSelectItemAtAlbumItem(at indexPath: IndexPath) {
        requestListMusic(album: listAlbum[indexPath.row])
    }
    
    func didSelectItemAtArtistItem(at indexPath: IndexPath) {
        let artistView = ArtistViewController()
        artistView.artist = listRelated[indexPath.row]
        pushView = artistView
    }
    
    func cellForItemAtAlbumItem(at indexPath: IndexPath) -> Album? {
        if listAlbum.indices.contains(indexPath.row) {
            return listAlbum[indexPath.row]
        }
        return nil
    }
    
    func cellForItemAtArtistItem(at indexPath: IndexPath) -> Artist? {
        if listRelated.indices.contains(indexPath.row) {
            return listRelated[indexPath.row]
        }
        return nil
    }
    
    func loadImage(url: String, index: Int, imageType: Int) {
        isLoading = true
        ImageRequester().getImage(url: url) { (response) in
            
            switch response {
            case .success(let model):
                
                switch imageType {
                case self.topImage:
                    self.artistImage = model
                    break
                case self.albumImages:
                    
                    if self.listAlbum.indices.contains(index) {
                        self.listAlbum[index].image = model
                    }
                    if self.listAlbum.indices.contains(index + 1) {
                        self.loadImage(url: self.listAlbum[index + 1].coverMediumUrl!, index: index + 1, imageType: imageType)
                    } else {
                        self.reloadAlbumsCollectionViewClosure!()
                    }
                    break
                case self.relatedImages:
                    
                    if self.listRelated.indices.contains(index) {
                        self.listRelated[index].image = model
                    }
                    if self.listRelated.indices.contains(index + 1) {
                        self.loadImage(url: self.listRelated[index + 1].pictureMediumUrl!, index: index + 1, imageType: imageType)
                    } else {
                        self.reloadRelatedCollectionViewClosure!()
                    }
                    break
                default: break
                }
                self.isLoading = false
            case .noConnection(let description):
                self.isLoading = false
                print(description)
            case .serverError(let description):
                self.isLoading = false
                print(description)
            case .timeOut(let description):
                self.isLoading = false
                print(description)
            case .downloadCanceled(_ ):
                self.loadImage(url: url, index: index, imageType: imageType)
            case .invalidResponse:
                self.isLoading = false
                print("Invalid Response")
            }
        }
    }
    
    func requestListRelatedArtist(artist: Artist) {
        Requester().requestListArtist(
            artist: artist,
            onStart: { () in
                isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listArtist in
            self.listRelated = listArtist
            self.reloadRelatedCollectionViewClosure!()
            self.loadImage(url: listArtist[0].pictureMediumUrl!, index: 0, imageType: self.relatedImages)
        }
        )
    }
    
    func requestListAlbum(artist: Artist) {
        Requester().requestListAlbum(
            artist: artist,
            onStart: { () in
                self.isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listAlbum in
            self.listAlbum = listAlbum
            self.reloadAlbumsCollectionViewClosure!()
            self.loadImage(url: listAlbum[0].coverMediumUrl!, index: 0, imageType: self.albumImages)
        }
        )
    }
    
    func requestListMusic(artist: Artist) {
        Requester().requestListMusic(
            artist: artist,
            onStart: { () in
                self.isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listMusic in
            self.isLoading = false
            let musicView = MusicViewController()
            musicView.listMusic = listMusic
            self.pushView = musicView
        }
        )
    }
    
    func requestRadio(artist: Artist) {
        Requester().requestRadio(
            artist: artist,
            onStart: { () in
                self.isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listMusic in
            self.isLoading = false
            let musicView = MusicViewController()
            musicView.listMusic = listMusic
            self.pushView = musicView
        }
        )
    }
    
    func requestListMusic(album: Album) {
        Requester().requestListMusic(
            album: album,
            onStart: { () in
                self.isLoading = true
                
        }, onError: { message in
            self.isLoading = false
            
        }, onSuccess: { listMusic in
            self.isLoading = false
            let musicView = MusicViewController()
            musicView.listMusic = listMusic
            self.pushView = musicView
        }
        )
    }
}
