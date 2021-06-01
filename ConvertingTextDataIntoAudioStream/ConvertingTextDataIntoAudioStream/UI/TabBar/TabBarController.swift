//
//  TabBarController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    lazy var player = Player.default
    lazy var notifictionCenter = NotificationCenter.default
    
    var playerView: PlayerView! {
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
        playerView = PlayerView()
        playerView.delegate = self
        hidePlayerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notifictionCenter.addObserver(self, selector: #selector(onPlayerDidStart), name: Player.playerDidStartNotification, object: nil)
        notifictionCenter.addObserver(self, selector: #selector(onPlayerDidFinish), name: Player.playerDidFinishNotification, object: nil)
        notifictionCenter.addObserver(self, selector: #selector(onPlayerDidPause), name: Player.playerDidPauseNotification, object: nil)
        notifictionCenter.addObserver(self, selector: #selector(onPlayerDidContinue), name: Player.playerDidContinueNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notifictionCenter.removeObserver(self)
    }
    
    @objc
    func onPlayerDidStart() {
        playerView.bookName.text = player.book?.name
        showPlayerView()
    }
    
    @objc
    func onPlayerDidFinish() {
        hidePlayerView()
    }
    
    @objc
    func onPlayerDidPause() {
        setPalyerViewToPausedState()
    }
    
    @objc
    func onPlayerDidContinue() {
        setPalyerViewToPlayingState()
    }
    
    private func showPlayerView() {
        viewControllers?.forEach {
            $0.additionalSafeAreaInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: playerView.frame.height,
                right: 0
            )
        }
        playerView.isHidden = false
    }
    
    private func hidePlayerView() {
        viewControllers?.forEach {
            $0.additionalSafeAreaInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
        }
        playerView.isHidden = true
    }
    
    private func setPalyerViewToPausedState() {
        playerView.PlayAndPauseButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
    }
    
    private func setPalyerViewToPlayingState() {
        playerView.PlayAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
    }
}

extension TabBarController: PlayerViewDelegate {
    func playerViewDelegatDidTapStopButton() {
        hidePlayerView()
        player.stop()
    }
    
    func playerViewDelegatDidTapPlayAndPauseButton() {
        if player.isPaused {
            player.continuePlay()
        } else {
            player.pause()
        }
    }
    
    func playerViewDelegatDidTapPreviousSentenceButton() {//rename
        player.rewindToPreviouseSentence()
    }
    
    func playerViewDelegatDidTapNextSentenceButton() {//rename
        player.rewindToNextSentence()
    }
    
}
