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
    
    // MARK: - Properties
    let model: House
    
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
    
    // MARK: - Sync

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }

    // Mark: - sync
    func syncModelWithView() {
        // Model -> View
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        //        title = model.name
    }
    
    // Mark: - UI
    func setupUI(){
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        navigationItem.rightBarButtonItem = wikiButton
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
    
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        <#code#>
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        <#code#>
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        <#code#>
    }
    
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        image = nill
        // Dispose of any resources that can be recreated. Si no se libera memoria rapidamente tras recibir el warning,
        //será el SO quien nos cerrará la app
    }

*/
}
