//
//  GenreCellViewModel.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 12/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

class GenreCellViewModel {
    
    var listArtist: [Artist]?
    
    var reloadTableViewClosure: (()->())?
    
    func loadImage(url: String, index: Int) {
        ImageRequester().getImage(url: url) { (response) in
            
            switch response {
            case .success(let model):
                
                if self.listArtist!.indices.contains(index) {
                    self.listArtist![index].image = model
                }
                if self.listArtist!.indices.contains(index + 1) {
                    self.loadImage(url: self.listArtist![index + 1].pictureMediumUrl!, index: index + 1)
                } else {
                    self.reloadTableViewClosure!()
                }
            case .noConnection(let description):
                print(description)
            case .serverError(let description):
                print(description)
            case .timeOut(let description):
                print(description)
            case .downloadCanceled(_ ):
                self.loadImage(url: url, index: index)
            case .invalidResponse:
                print("Invalid Response")
            }
        }
    }
}
