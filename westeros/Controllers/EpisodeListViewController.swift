//
//  EpisodeListViewController.swift
//  westeros
//
//  Created by Hector Aguado on 26/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    
    // MARK: - Properties
    var model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    // Nos damos de alta de las notificaciones
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func seasonDidChange(notification: Notification){
        guard let info = notification.userInfo else { return }
        let season = info[SEASON_KEY] as? Season
        model = (season?.episodes.sorted())!
        tableView.reloadData()
    }
    

    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EpisodeCell"
        // Qué episodio mostrar
        let episode = model[indexPath.row]
        // Reutilizar celda o crearla
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        //        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        //        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: cellId)}

        // Sincronizar celda y episodio
        cell.textLabel?.text = episode.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Descubrir que Episodio se ha pulsado
        let episode = model[indexPath.row]
        // Crear controlador
        let episodeDetailViewControler = EpisodeDetailViewController(model: episode)
        // Hacer un push
        navigationController?.pushViewController(episodeDetailViewControler, animated: true)
    }
    
}
