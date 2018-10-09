//
//  GenreTableViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 05/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var artistCollectionView: UICollectionView!
    
    let placeHolder = UIImage(named: "account_circle_white_48pt")!
    let cellIdentifier = "ArtistCollectionViewCell"
    var listArtist = [Artist]()
    var listImages = [UIImage]()
    var imageCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        artistCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
    }
    
    func prepareCells(){
        artistCollectionView.reloadData()
        if let url = listArtist[0].pictureUrl {
            loadImage(url: url)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArtist.count > 0 ? listArtist.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ArtistCollectionViewCell
            else {
                return ArtistCollectionViewCell()
        }
        if listArtist.indices.contains(indexPath.row) {
            cell.lbName.text = listArtist[indexPath.row].name
        }
        if listImages.indices.contains(indexPath.row) {
            cell.imageView.image = listImages[indexPath.row].af_imageRoundedIntoCircle()
        } else {
            cell.imageView.image = placeHolder
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    fileprivate func loadImage(url: String) {
        ImageRequester().getImage(url: url) { (response) in
            
            switch response {
            case .success(let model):
                self.listImages.append(model)
                self.imageCount += 1
                if self.listArtist.count > self.imageCount {
                    self.loadImage(url: self.listArtist[self.imageCount].pictureUrl!)
                } else {
                    self.artistCollectionView.reloadData()
                }
            case .noConnection(let description):
                print(description)
            case .serverError(let description):
                print(description)
            case .timeOut(let description):
                print(description)
            case .downloadCanceled(_ ):
                self.loadImage(url: url)
            case .invalidResponse:
                print("Invalid Response")
            }
        }
    }
}
