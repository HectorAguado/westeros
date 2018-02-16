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
    let model: House
    
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
    
    // Mark: - Sync
    func syncModelWithView(){
        title = model.name
        webView.load(URLRequest(url: model.wikiURL))
    }

}
// hacemos que implemente este protocolo. Al parecer tiene todos sus metodos con un valor por defecto, asi que implemenmtamos el que necesitamos
//
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







