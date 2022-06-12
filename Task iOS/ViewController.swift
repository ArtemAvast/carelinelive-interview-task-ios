//
//  ViewController.swift
//  Task iOS
//
//  Created by Dec Norton on 10/06/2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // https://open.spotify.com/playlist/0UA4PppdcKIKojVy5iSVoD
        SpotifyApi.shared.fetchPlaylist(id: "0UA4PppdcKIKojVy5iSVoD")
                .subscribe(onNext: { playlist in
                    debugPrint(playlist)
                })
    }
}

