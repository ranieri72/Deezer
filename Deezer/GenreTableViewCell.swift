//
//  GenreTableViewCell.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 05/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var artistCollectionView: UICollectionView!
    
    var imageArray = [String] ()
    let cellIdentifier = "ArtistCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        artistCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        artistCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func prepareCells(){
        backgroundColor = .blue
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ArtistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ArtistCollectionViewCell
        {
            let randomNumber = Int(arc4random_uniform(UInt32(imageArray.count)))
            cell.imageView.image = UIImage(named: imageArray[randomNumber])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 320, height: 320)
        return size
    }
}
