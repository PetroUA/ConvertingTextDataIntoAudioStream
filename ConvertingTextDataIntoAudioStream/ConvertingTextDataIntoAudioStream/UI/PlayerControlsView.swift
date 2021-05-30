//
//  PlayerControlsView.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//

import UIKit


class PlayerControlsView: UIView {
    
    let player = Player()
    var isPlaedButton = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var PlayAndPauseButton: UIButton!
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        player.stop()
    }
    
    @IBAction func PlayAndPauseButtonTapped(_ sender: Any) {
        if isPlaedButton {
            PlayAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
            isPlaedButton = false
            player.continuePlay()
        } else {
            PlayAndPauseButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
            isPlaedButton = true
            player.pause()
        }
    }
    
    @IBAction func previousSentenceButtonTapped(_ sender: Any) {
        player.previousSentence()
    }
    
    @IBAction func nextSentenceButtonTapped(_ sender: Any) {
        player.nextSentence()
    }
    
    func setup() {
        let contentView = Bundle(for: PlayerControlsView.self).loadNibNamed("PlayerControlsView", owner: self, options: nil)!.first as! UIView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
