//
//  TabBarController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    var playerView: PlayerControlsView! {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let playerView = playerView {
                playerView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(playerView)
                NSLayoutConstraint.activate([
                    playerView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
                    playerView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
                    playerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
                ])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView = PlayerControlsView()
    }
    
    
}
