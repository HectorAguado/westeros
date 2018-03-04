//
//  EpisodeDetailViewController.swift
//  westeros
//
//  Created by Hector Aguado on 27/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var seasonImage: UIImageView!
    
    // MARK: - Properties
    let model: Episode
    // MARK: - Initialization
    init(model: Episode){
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.title
    }
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = model.title
        super.viewWillAppear(animated)
        syncModelWithView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: NSNotification.Name(rawValue: SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func seasonDidChange(notification: Notification){
//        guard let info = notification.userInfo else { return }
//        let season = info[SEASON_KEY] as? Season
//        let episodeListVC = EpisodeListViewController(model: (season?.episodes.sorted())!)
        navigationController?.popViewController(animated: true)
    }

    
    
    

    func syncModelWithView(){
        let episode = model
        guard let season = model.season else {return}
        let episodes = episode.season!.sortedEpisodes
        var episodeNumber = 0
        var encontrado = false
        while (!encontrado){
            if (episodes[episodeNumber] == episode){
                encontrado = true
            }
            episodeNumber += 1
        }
        seasonEpisodeLabel.text = "\(season.name.rawValue) Episodio \(episodeNumber)"
        titleLabel.text = model.title
        releaseDateLabel.text = "Fecha estreno: \(model.releaseDate.stringfy)"
        seasonImage.image = model.season?.image
        synopsisLabel.text = model.synopsis
    }

}
