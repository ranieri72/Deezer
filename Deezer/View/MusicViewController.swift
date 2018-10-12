//
//  MusicViewController.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 10/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: MusicViewModel = {
        return MusicViewModel()
    }()
    
    let cellIdentifier = "MusicTableViewCell"
    let play = UIImage(named: "play_circle_filled_white_48pt")
    let pause = UIImage(named: "pause_circle_filled_white_48pt")
    
    var listMusic: [Music]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        title = "Musics"
        view.backgroundColor = Colors.primary
        
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.primary
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listMusic?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MusicTableViewCell
        let music = listMusic![indexPath.row]
        cell?.configure(music: music)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MusicTableViewCell {
            cell.playIcon.image = play
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MusicTableViewCell {
            cell.playIcon.image = pause
        }
        let previewUrl = listMusic![indexPath.row].previewUrl
        viewModel.audioPlayer(urlString: previewUrl!)
    }
}
