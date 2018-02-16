//
//  HouseListViewController.swift
//  westeros
//
//  Created by Hector Aguado on 15/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class HouseListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [House]
    
    // Mark: -  Initialization
    init(model: [House]) {
        self.model = model
        super.init(style: .grouped) //plai or grouped (sin o con espacios entre secciones)
        title = "Westeros"
    }
    
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    // Obligatorias al implementar UITableViewController
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1  // una sóla seccion de momento, todos los datos del mismo estilo
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        // Descubrir cual es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar house (model) con cell (vista)
        cell?.imageView?.image = house.sigil.image   // es opcionar porque dequeueReusable intenta recuperar la celda de caché
        cell?.textLabel?.text = house.name
    
        return cell! // hemos comprobado antes de que no será nil
    }
    
    
    // Mark: - Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // averiguar que casa han pulsado
        let house = model[indexPath.row]
        
        // crear un controlador de detalle de esa casa
        let houseDetailViewController = HouseDetailViewController(model: house)
        
        // hacer un push
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
    
    
}
