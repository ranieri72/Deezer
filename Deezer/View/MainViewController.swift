//
//  MainViewController.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 03/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, GenreViewProtocol {
    
    @IBOutlet weak var genreTableView: UITableView!
    var searchTableView: UITableView!
    var subView: UIView!
    var searchBar: UISearchBar!
    
    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    let genrecellIdentifier = "GenreTableViewCell"
    let searchCellIdentifier = "SearchArtistTableViewCell"
    
    var searchBarButton: UIBarButtonItem!
    var searchBarItem: UIBarButtonItem!
    var cancelBarButton: UIBarButtonItem!
    var appName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initVM()
    }
    
    func initView() {
        appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String
        title = appName
        
        view.backgroundColor = Colors.primary
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height
        
        // searchBar
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: displayWidth * 0.58, height: 20))
        searchBar.delegate = self
        searchBar.placeholder = "Search artist"
        searchBar.setTextColor(color: .white)
        searchBar.setTextFieldColor(color: .clear)
        searchBar.setPlaceholderTextColor(color: .white)
        searchBar.setSearchImageColor(color: .white)
        searchBar.setTextFieldClearButtonColor(color: .white)
        
        // barButtonItems
        searchBarButton = UIBarButtonItem.init(image: UIImage(named: "search_white_36pt"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(MainViewController.searchBarButtonAction))
        searchBarItem = UIBarButtonItem(customView: searchBar)
        cancelBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(MainViewController.cancelBarButtonAction))
        navigationItem.rightBarButtonItem = searchBarButton
        
        // genreTableView
        let nibGenre = UINib.init(nibName: genrecellIdentifier, bundle: nil)
        genreTableView.register(nibGenre, forCellReuseIdentifier: genrecellIdentifier)
        genreTableView.dataSource = self
        genreTableView.delegate = self
        genreTableView.tableFooterView = UIView()
        genreTableView.backgroundColor = Colors.primary
        
        // searchTableView
        let nibSearch = UINib.init(nibName: searchCellIdentifier, bundle: nil)
        searchTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - displayHeight))
        searchTableView.register(nibSearch, forCellReuseIdentifier: searchCellIdentifier)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.backgroundColor = UIColor.clear
        
        // subView
        subView = UIView(frame: CGRect(x: 0, y: barHeight, width: displayWidth + displayWidth, height: displayHeight + displayHeight))
        subView.backgroundColor = UIColor(white: 0, alpha: 0.9)
    }
    
    func initVM() {
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        }
        
        viewModel.reloadGenreTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.genreTableView.reloadData()
            }
        }
        
        viewModel.reloadSearchTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
        
        viewModel.requestListGenre()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func searchBarButtonAction() {
        title = ""
        view.addSubview(subView)
        view.addSubview(searchTableView)
        navigationItem.leftBarButtonItem = searchBarItem
        navigationItem.rightBarButtonItem = cancelBarButton
    }
    
    @objc func cancelBarButtonAction() {
        title = appName
        dismissKeyboard()
        searchTableView.removeFromSuperview()
        subView.removeFromSuperview()
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchText: searchText)
    }
    
    func didSelectArtist(artist: Artist) {
        let artistView = ArtistViewController()
        artistView.artist = artist
        navigationController?.pushViewController(artistView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == genreTableView {
            return viewModel.titleForHeaderInSection(at: section)
        } else {
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == genreTableView {
            return 200
        } else {
            return 75
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == genreTableView {
            return viewModel.numberOfSections
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == genreTableView {
            return 1
        } else {
            return 10//viewModel.numberOfRowsSearchTable
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == genreTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: genrecellIdentifier, for: indexPath) as! GenreTableViewCell
            if let listArtists = viewModel.cellForListArtist(at: indexPath) {
                cell.listArtist = listArtists
                cell.delegate = self
                cell.prepareCells()
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: searchCellIdentifier, for: indexPath) as? SearchArtistTableViewCell
            if let searchArtist = viewModel.cellForSearchArtist(at: indexPath) {
                cell!.configure(artist: searchArtist)
            }
            return cell!
        }
    }
}
