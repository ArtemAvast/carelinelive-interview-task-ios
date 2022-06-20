//
//  MainScreenCoordinator.swift
//  Task iOS
//
//  Created by Artem Burdak on 18.06.2022.
//

import UIKit
import RxSwift

final class MainScreenFlowCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ completion: @escaping () -> Void) {
        let vc: PlaylistsViewController = PlaylistsViewController.create(fromStoryboard: .main)
        vc.viewModel = PlaylistsViewModelImplementation(disposeBag: disposeBag, eventHandler: { [weak self] event in
            switch event {
            case .selectedPlaylist(let playlist):
                self?.open(playlist: playlist)
            default: break
            }
        })
        navigationController?.show(vc, sender: self)
    }
    
    private func open(playlist: SpotifyPlaylist) {
        let vc: PlaylistDetailsViewController = PlaylistDetailsViewController.create(fromStoryboard: .main)
        vc.viewModel = PlaylistDetailsViewModelImpl(disposeBag: disposeBag, playlist: playlist, eventHandler: { [weak self] event in
            switch event {
            case .selectedTrack(let track):
                self?.open(track: track)
            }
        })
        navigationController?.show(vc, sender: self)
    }
    
    private func open(track: SpotifyTrack) {
        let vc: PlayerViewController = PlayerViewController.create(fromStoryboard: .main)
        vc.viewModel = PlayerViewModelImpl(disposeBag: disposeBag, track: track)
        navigationController?.present(vc, animated: true)
    }
}
