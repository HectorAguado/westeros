//
//  AppDelegate.swift
//  westeros
//
//  Created by Hector Aguado on 8/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let splitViewController = UISplitViewController()
    var houseListViewController: HouseListViewController?
    var seasonListViewController: SeasonListViewController?
    var houseDetailViewController: HouseDetailViewController?
    var seasonDetailViewController: SeasonDetailViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)   //le damos el tamaño de nuestro dispositivo
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()  // hay que hacerla visible
        
        //creamos los modelos (abstraemos el origen de los datos)
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Inicializamos/Creamos los Controladores ( masterVC, detailVC)
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        
//        let lastSelectedHouse = houseListViewController!.lastSelectedHouse()
//        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        houseDetailViewController = HouseDetailViewController(model: houses.first!)
        seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Creamos combinador
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [
            houseListViewController!.wrappedInNavigation(),
            seasonListViewController!.wrappedInNavigation()
        ]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Crear el UISplitVC y le asignamos los viewControllers (master y detail)
            splitViewController.viewControllers = [
                tabBarViewController.wrappedInNavigation(),
                houseDetailViewController!.wrappedInNavigation(),
                seasonDetailViewController!.wrappedInNavigation()
            ]
            // Asignamos delegados
            tabBarViewController.delegate = self
            houseListViewController?.delegate = houseDetailViewController
            seasonListViewController?.delegate = seasonDetailViewController
            
            splitViewController.preferredDisplayMode = .allVisible
            // Asignamos el rootVC -> Indicamos QUÉ Queremos que se muestre
            window?.rootViewController = splitViewController
        } else {
            // Asignamos el rootVC -> Indicamos QUÉ Queremos que se muestre
            window?.rootViewController = tabBarViewController
        }
        

        
        // varios elementos de UI tienen un proxy .appearance() con muchos métodos para cambiar la apariencia
        UINavigationBar.appearance().backgroundColor = .red
        
        
        
// Mostrando TableView

        
        // creamos la table
        //let houseListViewController = HouseListViewController(model: houses)
        // Asignamos el rootVC -> Indicamos QUÉ Queremos que se muestre
        //window?.rootViewController = houseListViewController.wrappedInNavigation()

// Monstrando TabBarController
     //Forma 2
        // Creamos los Combinadores
/*        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers =
            houses
                .map {HouseDetailViewController(model: $0)}
                .map {$0.wrappedInNavigation()}
    //Forma 1
         let controllers = houses.map{ house in
         return HouseDetailViewController(model: house).wrappedInNavigation()
         }
         let tabBarViewController = UITabBarController()
         tabBarViewController.viewControllers = controllers
         
        // Asignamos el rootVC -> Indicamos QUÉ Queremos que se muestre
        window?.rootViewController = tabBarViewController
*/
       
        return true
    }
    
}

extension AppDelegate: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        // obtenemos el ListViewControler pulsado
            //        let vc2 = (viewController as! UINavigationController).viewControllers.first
        
        let vc = viewController.childViewControllers[0]
        
        // Desempaquetamos, preguntamos si es de un tipo u otro y actualizamos el window.rootVC
        guard let houseDetailViewController = houseDetailViewController else {return}
        guard let seasonDetailViewController = seasonDetailViewController else {return}
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if vc is HouseListViewController {
                window?.rootViewController?.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: self)
                // splitViewController.viewControllers[1] = (houseDetailViewController?.wrappedInNavigation())!
                return
            }
            if vc is SeasonListViewController{
                splitViewController.viewControllers[1] = seasonDetailViewController.wrappedInNavigation()
                window?.rootViewController = splitViewController
                // window?.rootViewController?.showDetailViewController(seasonListViewController!, sender: self)
            }
        }
    }
}
