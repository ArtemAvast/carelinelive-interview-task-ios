//
//  BaseCoordinator.swift
//  Task iOS
//
//  Created by Artem Burdak on 18.06.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start(_ completion: @escaping () -> Void )
}
