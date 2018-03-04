//
//  MemberListViewController.swift
//  westeros
//
//  Created by Hector Aguado on 19/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

// MARK: - Delegado
protocol MemberListViewControllerDelegate: class {
    func memberListViewController(_ vc: MemberListViewController, didSelectedMember member: Person)
}
class MemberListViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundSigilImage: UIImageView!
    
    // Mark: - Properties
    var model: [Person]
    weak var delegate: MemberListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Person]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
        //  TODO:      backgroundSigilImage.image =
        // a ver si averigüo como pasar la imagen
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification){
        guard let info = notification.userInfo else { return }
        let house = info[HOUSE_KEY] as? House
        model = (house?.sortedMembers)!
        tableView.reloadData()
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Asignamos la fuente de datos y el delegado
        tableView.dataSource = self
        tableView.delegate = self
    }

}


// Mark: UITableViewSouerce
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "MemberCell"
        
        // Descubrir la pensona que queremos mostrar
        let person = model[indexPath.row]
        // reguntar por una celda (a una cache) o crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        // let tableView.dequeueReusableCell(withIdentifier: cellID)
        // ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
        // Equivale a que si cell == nil, le asigna eso
        
        // Sincronizar celda y persona
        cell?.textLabel?.text = person.fullName
        cell?.imageView?.image = person.photo
        // Devolver la celda
        return cell!
    }

}

// Mark: UITableViewDelegate
extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Qué persona se ha pulsado
        let member = model[indexPath.row]
//        delegate?.memberListViewController(self, didSelectedMember: member)
        
        // Cramos controlador de detalle para esa temporada
        let memberDetailViewController = MemberDetailViewController(model: member)
        // hacemos un push
        navigationController?.pushViewController(memberDetailViewController, animated: true)
        
        
        
    }
}



