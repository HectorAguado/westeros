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

    var window: UIWindow?   //debe ser var porque aqui ahora mismo tiene valor nil, y necesitamos cambiarlad. Si el tipo va a ser opcional, no tiene sentido que sea una constante


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)   //le damos el tamaño de nuestro dispositivo
        window?.backgroundColor = .cyan  // swift usa la inferencia de tipos a sabe que es un UIColor, in enumerados podemos poner .valor directamente
        
        window?.makeKeyAndVisible()  // hay que hacerla visible

// DEFINITIVO
        //creamos el modelo
        let houses = Repository.local.houses  // abstraemos el origen de los datos
        
        // creamos la table
        let houseListViewController = HouseListViewController(model: houses)
//        let controllers = houses.map{ house in
//            return HouseDetailViewController(model: house).wrappedInNavigation()
//        }
//        let tabBarViewController = UITabBarController()
//        tabBarViewController.viewControllers = controllers
//        window?.rootViewController = tabBarViewController
        window?.rootViewController = houseListViewController.wrappedInNavigation()


//        // Crear los Controladores
////        let starkHouseViewController = HouseDetailViewController(model: starkHouse)
////        let lannisterHouseViewControlller = HouseDetailViewController(model: lannisterHouse)
//
//        let houses = Repository.local.houses  // abstraemos el origen de los datos
//        var controllers = [UIViewController]()
//        for house in houses {
//            controllers.append(HouseDetailViewController(model: house).wrappedInNavigation())
//        }
//
//
//
////        var navigationControllers = [UINavigationController]()
////        for controller in controllers {
////            navigationControllers.append(controller.wrappedInNavigation())
////        }
//
//        // Creamos los Combinadores
//        let tabBarViewController = UITabBarController()
//        tabBarViewController.viewControllers = [
//            starkHouseViewController.wrappedInNavigation(),
//            lannisterHouseViewControlller.wrappedInNavigation()
//        ]
//
//
//        /*
//         tabBarViewController.viewControllers =
//            houses
//         .map {HouseDetailViewController(model: $0)}
//         .map {wrappedInNavigation($0)}
//
//         */
//
//
//        // Asignamos el rootVC -> Indicamos QUÉ Queremos que se muestre
//        window?.rootViewController = tabBarViewController

        
        return true
    }

    
    
    
    
    
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

