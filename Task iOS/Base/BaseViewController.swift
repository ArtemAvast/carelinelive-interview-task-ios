//
//  BaseViewController.swift
//  Task iOS
//
//  Created by Artem Burdak on 18.06.2022.
//

import UIKit

public typealias EventHandler<Event> = (Event) -> ()

class BaseViewController: UIViewController {
    static func create<T>(fromStoryboard: StoryboardNames) -> T {
        let storyboard = UIStoryboard(name: fromStoryboard.description, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! T
        return controller
    }
    
    private var processingView: UIView?
    
    func processingView(isActive: Bool) {
        if isActive {
            processingView = UIView(frame: self.view.bounds)
            processingView?.backgroundColor = .black
            let processing = UIActivityIndicatorView(style: .large)
            processing.center = processingView?.center ?? CGPoint.zero
            processingView?.addSubview(processing)
            processing.startAnimating()
            
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            processingView.map { keyWindow?.addSubview($0) }
        } else {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.processingView?.alpha = 0
            }) { (_) in
                self.processingView?.removeFromSuperview()
                self.processingView = nil
            }
        }
    }
}
