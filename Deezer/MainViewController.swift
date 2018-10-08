//
//  MainViewController.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 03/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var genreTableView: UITableView!
    
    var data = [Artist]()
    let cellIdentifier = "GenreTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        genreTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        genreTableView.dataSource = self
        genreTableView.delegate = self
        genreTableView.estimatedRowHeight = 220
        genreTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Title \(section)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GenreTableViewCell
        else {
            return GenreTableViewCell()
        }
        cell.prepareCells()
        return cell
    }
}
