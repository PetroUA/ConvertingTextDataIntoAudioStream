//
//  PlayerControlsView.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//

import UIKit

protocol PlayerViewDelegate: AnyObject {
    func playerViewDelegatDidTapStopButton()
    func playerViewDelegatDidTapPlayAndPauseButton()
    func playerViewDelegatDidTapPreviousSentenceButton()
    func playerViewDelegatDidTapNextSentenceButton()
}

class PlayerView: UIView {
    
    weak var delegate: PlayerViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var PlayAndPauseButton: UIButton!
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        delegate?.playerViewDelegatDidTapStopButton()
    }
    
    @IBAction func playAndPauseButtonTapped(_ sender: Any) {
        delegate?.playerViewDelegatDidTapPlayAndPauseButton()
    }
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        delegate?.playerViewDelegatDidTapPreviousSentenceButton()
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        delegate?.playerViewDelegatDidTapNextSentenceButton()
    }
    
    func setup() {
        let contentView = Bundle(for: PlayerView.self).loadNibNamed("PlayerView", owner: self, options: nil)!.first as! UIView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    /*
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }*/
}
