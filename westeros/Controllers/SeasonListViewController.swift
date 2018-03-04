//
//  SeasonListViewControllerTableViewController.swift
//  westeros
//
//  Created by Hector Aguado on 26/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let SEASON_KEY = "SeasonKey"

// MARK: - Delegado
protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [Season]
    weak var delegate:SeasonListViewControllerDelegate?
    
    // MARK: - Inicialization
    init(model: [Season]){
        self.model = model
        super.init(style: .plain)
        title = "Temporadas"
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        // Descubrir qué temporada mostrar
        let season = model[indexPath.row]
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        // Sincronizar season (model) con cell (vista)
        cell?.textLabel?.text = season.name.rawValue
        cell?.detailTextLabel?.text = "Fecha de estreno: " + season.releaseDate.description //no funciona??
        cell?.imageView?.image = season.image
        return cell!
    }
 
    // MARK: - Table View Delegate
    // shoud, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Qué Temporada se ha pulsado
        let season = model[indexPath.row]
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            // Para el Split usaremos un delegado - Avisamos al delegado
            delegate?.seasonListViewController(self, didSelectSeason: season)

            // Notificaciones - Enviamos la misma info
            let notificationCenter = NotificationCenter.default
            let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])  // pasamos un diccionario con una clave y un valor
            
            notificationCenter.post(notification)
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            // crear un controlador de detalle de esa casa
            let seasonDetailViewController = SeasonDetailViewController(model: season)
            // hacer un push
            navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
    }
    
}
