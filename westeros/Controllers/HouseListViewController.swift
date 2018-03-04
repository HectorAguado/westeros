//
//  HouseListViewController.swift
//  westeros
//
//  Created by Hector Aguado on 15/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

let HOUSE_KEY = "HouseKey"
let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let LAST_HOUSE = "LAST_HOUSE"

// Mark: Creacion de Delegado Personalizado
protocol HouseListViewControllerDelegate: class {  // class va a ser sustituido por AnyObject 
    // should, will, did  -> en nuestro caso sólo nos interesa tras hacer click, osea did
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
    
}


class HouseListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate?  // va a nacesitar esta propiedad para poder pasarsela por propiedad, ya que de inicio no le vamos a dar valor
    
    // Mark: -  Initialization
    init(model: [House]) {
        self.model = model
        super.init(style: .grouped) //plain or grouped (sin o con espacios entre secciones)
        title = "Westeros"
    }
    
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Marck: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        let indexPath = IndexPath(row: lastRow, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
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
        cell?.imageView?.image = house.sigil.image   // es opcional porque dequeueReusable intenta recuperar la celda de caché
        cell?.textLabel?.text = house.name
    
        return cell! // hemos comprobado antes que no será nil
    }
    
    
    // Mark: - Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // averiguar que casa han pulsado
        let house = model[indexPath.row]

        // Para el Split, usamos nuetro delegado
        //Avisamos al delegado, que se encargará de propagarlo a quien le interese
        if UIDevice.current.userInterfaceIdiom == .pad {
            delegate?.houseListViewController(self, didSelectHouse: house)
            // Mando la misma info a traves de notificaciones
            let notificationCenter = NotificationCenter.default
            
            let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY : house])
            
            notificationCenter.post(notification)
        
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            // crear un controlador de detalle de esa casa
            let houseDetailViewController = HouseDetailViewController(model: house)
            // hacer un push
            navigationController?.pushViewController(houseDetailViewController, animated: true)
        }
        

        
        // PERSISTIR con USER DEFAULT  -  Hay que usar info muuy sencilla
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
    
}

extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int){
        let defaults = UserDefaults.standard    // es un diccionario
        defaults.set(row, forKey: LAST_HOUSE)
        // ya valdría, pero para asegurarnos de que se guarda si o si uno sunchronize
        defaults.synchronize()
    }
    func lastSelectedHouse() -> House {
        // extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        // Averiguar la casa de ese row
        let house = model[row]
        // Devolverla
        return house
    }
}






