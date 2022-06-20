//
//  AppConfigurator.swift
//  Task iOS
//
//  Created by Artem Burdak on 18.06.2022.
//

import UIKit

final class AppConfigurator {
    
    // MARK: - Private properties
    
    private var childCoordinator: Coordinator?
    
    private var rootViewController: UINavigationController?
    
    private let window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        
        self.rootViewController?.setNavigationBarHidden(true, animated: false)
        self.configureNavigationBar()
        self.start()
    }
    
    // MARK: - Private functions
    
    private func start() {
        self.showMainFlow()
    }
    
    private func showMainFlow() {
        guard let navigationController = self.rootViewController else { return }
        let mainCoordinator = MainScreenFlowCoordinator(navigationController: navigationController)
        self.childCoordinator = mainCoordinator
        mainCoordinator.start({})
    }
    
    private func configureNavigationBar() {
        self.rootViewController?.setNavigationBarHidden(false, animated: false)
        self.rootViewController?.navigationBar.tintColor = .green
        self.rootViewController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.rootViewController?.navigationBar.shadowImage = UIImage()
    }
}
