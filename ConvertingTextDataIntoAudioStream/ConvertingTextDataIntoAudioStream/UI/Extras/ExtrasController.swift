//
//  ExtrasController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit
// rate!!!, pitchMultiplier!!!, postUtteranceDelay!!!, volume!!! language!!!
class ExtrasController: UITableViewController {
    
    @IBOutlet private weak var languageRateLabel: UILabel!
    var dataLanguage: String = "Speech language"
    
    @IBOutlet private weak var volumeLabel: UILabel!
    var dataVolume: String = "Speech volume"
    
    @IBOutlet private weak var rateLabel: UILabel!
    var dataRate: String = "Speech rate"
    
    @IBOutlet private weak var pitchMultiplierLabel: UILabel!
    var dataPitchMultiplier: String = "Baseline pitch"
    
    @IBOutlet private weak var postUtteranceDelayLabel: UILabel!
    var dataPostUtteranceDelay: String = "Pauses after speaking"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateLabel.text = dataRate
        languageRateLabel.text = dataLanguage
        pitchMultiplierLabel.text = dataPitchMultiplier
        postUtteranceDelayLabel.text = dataPostUtteranceDelay
        volumeLabel.text = dataVolume
    }
}
