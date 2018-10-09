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
    
    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    let cellIdentifier = "GenreTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initVM()
    }
    
    func initView() {
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        genreTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        genreTableView.dataSource = self
        genreTableView.delegate = self
        genreTableView.tableFooterView = UIView()
    }
    
    func initVM() {
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.genreTableView.reloadData()
            }
        }
        
        viewModel.requestListGenre()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getNameOfSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GenreTableViewCell
            else {
                return GenreTableViewCell()
        }
        if let listArtists = viewModel.getCellViewModel(at: indexPath) {
            print(String(format: "Request indexPath: %d, listArtist: %@ \n", indexPath.section, listArtists[0].name!))
            cell.listArtist = listArtists
            cell.prepareCells()
        }
        return cell
    }
}
