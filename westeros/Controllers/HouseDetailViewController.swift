//
//  HouseDetailViewController.swift
//  westeros
//
//  Created by Hector Aguado on 12/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    @IBOutlet weak var backgroundSigilImage: UIImageView!
    
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        // Primero. Limpiar nuestro desorden
        self.model = model
        // Llamar a Super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self))) // si reciben nil, va a buscar un xib que se llame igual que la clase
            //en el bundle tb se puede poner nil, pero si trabajamos con micro frameworks, fallará, si ponemos como arriba, siempre funcionará
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      //  syncModelWithView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = model.name
        setupUI()
        syncModelWithView()
        
    }

    // MARK: - Sync
    func syncModelWithView() {
        // Model -> View
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        backgroundSigilImage.image = model.sigil.image
    }
    
    // Mark: - UI
    func setupUI(){
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        navigationItem.rightBarButtonItems = [wikiButton, membersButton]  // para más de un boton
    }
    //target indicamos donde buscar la acción
    // selector es un número que el sistema le asigna a cada una de nuestra funcion
    //para optenerlo #selector(nombreFuncion)
    
    @objc func displayWiki() {   // objc significa que ahí dentro tiene que ser 100% compatible con objetive C
        // Creamos el wikiVC
        let wikiViewController = WikiViewController(model: model)
        //hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    @objc func displayMembers(){
        // creamos el VC
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        //hacemos push
         navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
}

// Al implementar HouseListViewControllerDelegate, escuchamos
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
    
    
}
