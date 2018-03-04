//
//  SeasonDetailViewController.swift
//  westeros
//
//  Created by Hector Aguado on 26/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var seasonReleasedateLabel: UILabel!
    @IBOutlet weak var SeasonTotalEpisodes: UILabel!
    @IBOutlet weak var seasonImageView: UIImageView!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name.rawValue
    }
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = model.name.rawValue
        setupUI()
        syncModelWithView()
    }

    func setupUI(){
        // Creamos botones
        let episodeButton = UIBarButtonItem(title: "Episode List", style: .plain, target: self, action: #selector(displayEpisodes))
        // Los añadimos al navigationBar
        navigationItem.rightBarButtonItem = episodeButton
    }
    
    @objc func displayEpisodes(){
        // Creamos controlador
        let episodelistViewControler = EpisodeListViewController(model: model.sortedEpisodes)
        // Hacemos un push
        navigationController?.pushViewController(episodelistViewControler, animated: true)
    }
    
    // MARK: - Sync
    func syncModelWithView(){
        seasonNameLabel.text = model.name.rawValue
        seasonReleasedateLabel.text = "Fecha de estreno: " + model.releaseDate.stringfy
        SeasonTotalEpisodes.text = "\(model.episodes.count) Episodios"
        seasonImageView.image = model.image
        title = model.name.rawValue
    }
}

// Al implementar SeasonListViewControllerDelegate, escuchamos
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
    
    
}




