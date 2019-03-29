//
//  Coordinator.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

class Coordinator {
    
    weak var supercoordinator: Coordinator?
    lazy var viewController: UIViewController? = makeViewController()
    var isExpired = false
    
    private var subcoordinator: Coordinator?
    // method of removing current subcontroller
    private var childRemover: ((UIViewController) -> Void)?
    
    func makeViewController() -> UIViewController {
        assertionFailure("this method must be overriden")
        return UIViewController()
    }
    
    // MARK: - Lifecycle
    
    init() {
        
    }
    
    init(parent: Coordinator) {
        supercoordinator = parent
    }
    
    // MARK: - Child Management
    
    func add(subcoordinator child: Coordinator, presentationWith presenter: (UIViewController) -> Void, dismissalWith remover: @escaping (UIViewController) -> Void) {
        guard let viewController = child.viewController else {
            assertionFailure("every subcoordinator must have a viewController, but coordinator \(String(describing: subcoordinator)) did not")
            return
        }
        
        subcoordinator = child
        childRemover = remover
        
        presenter(viewController)
    }
    
    private func remove() {
        if let viewController = subcoordinator?.viewController {
            childRemover?(viewController)
            childRemover = nil
        } else {
            assertionFailure("this should not happen, but this can be removed if you know what you're doing")
        }
        
        if isExpired {
            finish() // remove this coordinator as well
        }
        
        subcoordinator = nil
    }
    
    // MARK: - Control
    
    func start() {
        
    }
    
    func finish() {
        isExpired = true
        
        supercoordinator?.remove()
    }
    
    // MARK: -
    
}
