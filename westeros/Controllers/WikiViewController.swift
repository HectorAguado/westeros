//
//  WikiViewController.swift
//  westeros
//
//  Created by Hector Aguado on 15/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!   // necesita importar WebKit
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // Mark: - Properties
    var model: House
    
    // Mark: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - I Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false // lo muestro
        loadingView.startAnimating() //lo animo
        webView.navigationDelegate = self  //WikiVC
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        // 1º, el observador, en este caso yo, el wikiViewController
        // selector: método que queremos que se ejecute cuando nos llegue la notificacion
        // name, nombre de la notificacion
        // onject : quien nos lo manda?
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja de las notificaciones  Tb me podría dar de baja en el "deinit", que se le llama cuando el objeto vaya a desaparecer de memoriaen este caso podemos volver a llamarlo, sin que desaparezca de memoria. Desapareceria al hacer pop
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // Mark: - Sync
    func syncModelWithView(){
        title = model.name
        webView.load(URLRequest(url: model.wikiURL))
    }

    // Mark: - Notifications
    @objc func houseDidChange(notification: Notification){
        // extraer el userInfo de la notificacion
//        let info = notification.userInfo!     //diccionario opcional, más elegante como abajo
        guard let info = notification.userInfo else {
            return
        }
        // Extraer la casa del userInfo
        let house = info[HOUSE_KEY] as? House
        
        // Actualizar el modelo
        model = house!
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
    
}
// hacemos que implemente este protocolo. Al parecer tiene todos sus metodos con un valor por defecto, asi que implemenmtamos el que necesitamos
extension WikiViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating() //paro animacion
        loadingView.isHidden = true //lo oculto
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}







