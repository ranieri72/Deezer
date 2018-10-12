//
//  ArtistViewController.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRelated: UILabel!
    @IBOutlet weak var lbAlbums: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRadio: UIButton!
    
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    lazy var viewModel: ArtistViewModel = {
        return ArtistViewModel()
    }()
    
    var artist: Artist?
    
    let artistCellIdentifier = "ArtistCollectionViewCell"
    let albumCellIdentifier = "AlbumCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initVM()
    }
    
    func initView() {
        title = artist!.name
        view.backgroundColor = Colors.primary
        lbName.text = artist?.name
        
        btnPlay.backgroundColor = Colors.accent
        btnPlay.layer.cornerRadius = 25
        
        btnRadio.backgroundColor = UIColor.clear
        btnRadio.layer.cornerRadius = 25
        btnRadio.layer.borderColor = Colors.accent.cgColor
        btnRadio.layer.borderWidth = 1
        
        let nibAlbum = UINib.init(nibName: albumCellIdentifier, bundle: nil)
        albumsCollectionView.register(nibAlbum, forCellWithReuseIdentifier: albumCellIdentifier)
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
        albumsCollectionView.backgroundColor = Colors.primary
        
        let nibArtist = UINib.init(nibName: artistCellIdentifier, bundle: nil)
        relatedCollectionView.register(nibArtist, forCellWithReuseIdentifier: artistCellIdentifier)
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        relatedCollectionView.backgroundColor = Colors.primary
    }
    
    func initVM() {
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        }
        
        viewModel.updateArtistImage = { [weak self] () in
            DispatchQueue.main.async {
                if let artistImage = self?.viewModel.artistImage {
                    self?.image.image = artistImage
                }
            }
        }
        
        viewModel.reloadAlbumsCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.albumsCollectionView.reloadData()
            }
        }
        
        viewModel.reloadRelatedCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.relatedCollectionView.reloadData()
            }
        }
        
        viewModel.pushToView = { [weak self] () in
            DispatchQueue.main.async {
                if let pushView = self?.viewModel.pushView {
                    //dismiss(animated: false, completion: nil)
                    self?.navigationController?.pushViewController(pushView, animated: true)
                }
            }
        }
        
        viewModel.loadImage(url: (artist?.pictureBigUrl)!, index: 0, imageType: viewModel.topImage)
        viewModel.requestListAlbum(artist: artist!)
        viewModel.requestListRelatedArtist(artist: artist!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == albumsCollectionView {
            return viewModel.numberOfItemsInListAlbum
        } else {
            return viewModel.numberOfItemsInListRelated
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == albumsCollectionView {
            let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellIdentifier, for: indexPath) as! AlbumCollectionViewCell
            
            if let album = viewModel.cellForItemAtAlbumItem(at: indexPath) {
                albumCell.configure(album: album)
            }
            return albumCell
            
        } else {
            let relatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: artistCellIdentifier, for: indexPath) as! ArtistCollectionViewCell
            
            if let related = viewModel.cellForItemAtArtistItem(at: indexPath) {
                relatedCell.configure(artist: related)
            }
            return relatedCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == albumsCollectionView {
            viewModel.didSelectItemAtAlbumItem(at: indexPath)
        } else {
            viewModel.didSelectItemAtArtistItem(at: indexPath)
        }
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        viewModel.requestListMusic(artist: artist!)
    }
    
    @IBAction func btnRadioAction(_ sender: UIButton) {
        viewModel.requestRadio(artist: artist!)
    }
}
