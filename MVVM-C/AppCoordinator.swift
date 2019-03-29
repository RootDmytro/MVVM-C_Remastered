//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    let container = AppContainer()
    
    override func makeViewController() -> UIViewController {
        return UINavigationController(rootViewController: UIViewController())
    }
    
    override func start() {
        showMenu()
    }
    
    func showMenu() {
        guard let navigationController = self.viewController as? UINavigationController else {
            return
        }
        
        let menu = MenuCoordinator(parent: self, container: container)
        add(subcoordinator: menu, presentationWith: { controller in
            navigationController.pushViewController(controller, animated: true)
        }, dismissalWith: { controller in
            navigationController.popViewController(animated: true)
        })
    }
}
