//
//  MenuCoordinator.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

class MenuCoordinator: Coordinator {

    let container: AppContainer
    
    init(parent: Coordinator, container: AppContainer) {
        self.container = container
        super.init(parent: parent)
    }
    
    override func makeViewController() -> UIViewController {
        let viewModel = MenuViewModel(container: container)
        
        // TODO: change
        let controller: MenuViewController = MenuViewController()
        controller.viewModel = viewModel
        
        return controller
    }
    
    func showNumberEdit(completion: (() -> Void)?) {
        guard let viewController = viewController as? MenuViewController else {
            return
        }
        
        // TODO: change
        let numberEdit = NumberEditCoordinator()
        add(subcoordinator: numberEdit, presentationWith: { controller in
            viewController.present(controller, animated: true, completion: nil)
        }, dismissalWith: { controller in
            controller.dismiss(animated: true, completion: completion)
        })
    }
    
}
