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
    
    lazy var viewModel: GenreCellViewModel = {
        return GenreCellViewModel()
    }()
    
    let cellIdentifier = "ArtistCollectionViewCell"
    var listArtist = [Artist]()
    weak var delegate: GenreViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initView()
        initVM()
    }
    
    func initView() {
        backgroundColor = Colors.primary
        
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        artistCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        artistCollectionView.backgroundColor = Colors.primary
    }
    
    func initVM() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.artistCollectionView.reloadData()
            }
        }
    }
    
    func prepareCells() {
        artistCollectionView.reloadData()
        let url = listArtist[0].pictureMediumUrl
        viewModel.listArtist = listArtist
        viewModel.loadImage(url: url!, index: 0)
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
            cell.configure(artist: listArtist[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectArtist(artist: listArtist[indexPath.row])
    }
}

protocol GenreViewProtocol: class {
    func didSelectArtist(artist: Artist)
}
